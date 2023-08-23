import Foundation

actor NetworkManager {
    private let decoder: JSONDecoder
    internal let authManager: AuthManager
    internal let cacheManager = CacheManager()
    
    func data<T: Codable>(from endpoint: Endpoint, authorize: Bool = true, retry: Bool = true) async throws -> T {
        if let status = cacheManager[endpoint.url] {
            switch status {
            case .cached(let response):
                print("response is cached")
                return response as! T
            case .pending(let task):
                print("response is pending")
                return try await task.value as! T
            }
        }
        
        print("Request")
        let request = authorize ? try await authManager.authorize(request: endpoint.request) : endpoint.request
    
        let task = Task<Codable, Error> {
            guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
                throw NetworkError.invalidHttpResponse
            }
            
            guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
                throw NetworkError.invalidHttpResponse
            }
            
            guard (200...299).contains( response.statusCode ) else {
//                if response.statusCode == 401 { //Unauthorized access
//                    let _ = try await authManager.refresh()
//                    print("token has been refreshed")
//                    return try await data(from: endpoint, retry: false)
//                }
                throw NetworkError.failure(statusCode: response.statusCode)
            }
            
            return try decoder.decode(T.self, from: data)
        }
        
        cacheManager[endpoint.url] = .pending(task)
        let response = try await task.value
        cacheManager[endpoint.url] = .cached(response)
        return response as! T
    }
    
    init(authManager: AuthManager = AuthManager(), decoder: JSONDecoder = JSONDecoder()) {
        self.authManager = authManager
        self.decoder = decoder
    }
}
