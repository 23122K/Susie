import Foundation
import Network

actor NetworkManager {
    private let monitor = NWPathMonitor()
    private let decoder = JSONDecoder()
    private let monitorQueue = DispatchQueue(label: "monitor.queue", attributes: .initiallyInactive)
    internal let auth: AuthManager
    internal let cache: CacheManager
    
    func startMonitoringNetwork() {
        monitor.pathUpdateHandler = { path in
            guard path.status == .satisfied else {
                print("Disconnected")
                return
            }
            print("Connected")
        }
        
        monitor.start(queue: monitorQueue)
    }
    
    func stopMonitoringNetwork() {
        monitor.cancel()
    }
    
    //TODO: Check if casting response as! T is save
    func data<T: Codable>(from endpoint: Endpoint, authorize: Bool = true, retry: Bool = true, policy: CachePolicy = CachePolicy()) async throws -> T {
        //Cache policy set to false wont trigger it as it requires endpoint to be cachable
        if let cache = cache[endpoint.url] {
            switch cache.status {
            case .cached(let response):
                return response as! T
            case .ongoing(let task):
                return try await task.value as! T
            }
        }
        
        print("Request is made")
        let request = authorize ? try await auth.authorize(request: endpoint.request) : endpoint.request
        let task = Task<Codable, Error> {
            guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
                throw NetworkError.invalidHttpResponse
            }
            
            guard (200...299).contains( response.statusCode ) else {
                throw NetworkError.failure(statusCode: response.statusCode)
            }
            
            return try decoder.decode(T.self, from: data)
        }
        
        
        guard policy.shouldCache else {
            return try await task.value as! T
        }
        
        cache[endpoint.url] = Cache(status: .ongoing(task))
        let response = try await task.value
        cache[endpoint.url] = Cache(status: .cached(response))
        return response as! T
    }
    
    init(authManager: AuthManager = AuthManager(), cacheManager: CacheManager = CacheManager { Date() }){
        self.auth = authManager
        self.cache = cacheManager
    }
}
