import Foundation

class NetworkManager {
    private let decoder: JSONDecoder
    internal let authManager: AuthManager
    
    func data<T: Response>(for request: URLRequest, authorize: Bool = true, retry: Bool = true) async throws -> T {
        let request = authorize ? try await authManager.authorize(request: request) : request
        
        guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
            throw NetworkError.invalidHttpResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            if response.statusCode == 401 { //Unauthorized access
                let _ = try await authManager.refresh()
                print("token has been refreshed")
                return try await self.data(for: request)
            }
            throw NetworkError.failure(statusCode: response.statusCode)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    func data<T: Response>(for request: URLRequest, authorize: Bool = true, retry: Bool = true) async throws -> [T] {
        guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
            throw NetworkError.invalidHttpResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            throw NetworkError.failure(statusCode: response.statusCode)
        }
        
        return try decoder.decode(Array<T>.self, from: data)
    }
    
    init(authManager: AuthManager = AuthManager(), decoder: JSONDecoder = JSONDecoder()) {
        self.authManager = authManager
        self.decoder = decoder
    }
}
