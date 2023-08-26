import Foundation
import Network

protocol NetworkStatusDelegate: AnyObject {
    func networkStatusDidChange(to status: NetworkStatus)
}

enum NetworkStatus {
    case connected
    case disconnected
}

class NetworkManager: NetworkStatusDelegate {

    let auth: AuthManager
    let cache: CacheManager
    let networkMonitor: NetworkMonitor
    let decoder: JSONDecoder = JSONDecoder()
    
    var hasInternetConnection: Bool = false
    
    func networkStatusDidChange(to status: NetworkStatus) {
        switch status {
        case .connected:
            hasInternetConnection = true
        case.disconnected:
            hasInternetConnection = false
        }
    }

    //TODO: Check if casting response as! T is save
    func data<T: Codable>(from endpoint: Endpoint, authorize: Bool = true, retry: Bool = true, policy: CachePolicy = CachePolicy(shouldCache: true)) async throws -> T {
        
        guard hasInternetConnection else {
            throw NetworkError.noInternetConnection
        }
        
        if let entry = await cache.fetch(for: endpoint.url) {
            switch entry.status {
            case .ongoing(let task):
                return try await task.value as! T
            case .cached(let response):
                return response as! T
            case .completed:
                break
            }
        }
        
        let request = authorize ? try await auth.authorize(request: endpoint.request) : endpoint.request
        let task = Task<Codable, Error> {
            guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
                throw NetworkError.invalidHTTPResponse
            }
            
            guard (200...299).contains( response.statusCode ) else {
                throw NetworkError.failure(statusCode: response.statusCode)
            }
            
            return try decoder.decode(T.self, from: data)
        }
        
        
        var entry = CacheEntry(status: .ongoing(task))
        await cache.insert(entry: entry, for: endpoint.url)
        let response = try await task.value
        
        guard policy.shouldCache else {
            entry = CacheEntry(status: .completed)
            await cache.insert(entry: entry, for: endpoint.url)
            return response as! T
            
        }
        
        entry = CacheEntry(status: .cached(response))
        await cache.insert(entry: entry, for: endpoint.url)
        return response as! T
    }
    
    init(authManager: AuthManager = AuthManager(), networkMonitor: NetworkMonitor = NetworkMonitor(), cacheManager: CacheManager = CacheManager { Date() }){
        self.auth = authManager
        self.cache = cacheManager
        self.networkMonitor = networkMonitor
        self.networkMonitor.delegate = self
    }
}
