import Foundation
import Network

protocol NetworkStatusDelegate: AnyObject {
    func networkStatusDidChange(to status: NetworkStatus)
}

enum NetworkStatus {
    case connected
    case disconnected
}


actor NetworkManager {
    let cache: CacheManager
    let keychain: KeychainManager
    
    private var hasInternetConnection: Bool = true
    private var refreshTask: Task<Auth, Error>?
    
    private var decoder: JSONDecoder = JSONDecoder()
    
    //MARK: Authorization
    private var auth: Auth {
        get async throws {
            if let task = refreshTask {
                return try await task.value
            }
        
            guard let accessAuth = keychain[.accessAuth] else {
                throw AuthError.authObjectIsMissing
            }
            

            guard accessAuth.isValid else {
                return try await refresh()
            }
            
            return accessAuth
        }
    }
    
    private func authorize(request: URLRequest) async throws -> URLRequest {
        let auth = try await auth
        var request = request
        request.addValue("Bearer \(auth.token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    private func refresh() async throws -> Auth {
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }
        
        guard let refreshAuth = keychain[.refreshAuth] else {
            throw AuthError.authObjectIsMissing
        }
        
        guard refreshAuth.isValid else {
            throw AuthError.couldNotRefreshAuthObject
        }
        
        let task = Task { () throws -> Auth in
            defer { refreshTask = nil }
            
            let endpoint = Endpoints.refreshToken(token: refreshAuth.token)
            return try await response(from: endpoint)
        }
        
        self.refreshTask = task
        return try await task.value
    }
    
    private func response<T: Codable>(from endpoint: Endpoint) async throws -> T {
        guard hasInternetConnection else { throw NetworkError.noInternetConnection }
        guard let (data, response) = try await URLSession.shared.data(for: endpoint.request) as? (Data, HTTPURLResponse) else {
            throw NetworkError.invalidHTTPResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            throw NetworkError.failure(statusCode: response.statusCode)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    func response<T: Codable>(from endpoint: Endpoint, authorize: Bool = true, retry: Bool = true, policy: CachePolicy = CachePolicy()) async throws -> T {
        guard hasInternetConnection else { throw NetworkError.noInternetConnection }
        
        if let entry = cache[endpoint] {
            switch entry.status {
            case .ongoing(let task):
                return try await task.value as! T
            case .cached(let response):
                return response as! T
            case .completed:
                break
            }
        }
        
        let request = authorize ? try await self.authorize(request: endpoint.request) : endpoint.request
        
        let task = Task<Codable, Error> {
            guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
                throw NetworkError.invalidHTTPResponse
            }
            
            guard (200...299).contains( response.statusCode ) else {
                throw NetworkError.failure(statusCode: response.statusCode)
            }
            
            
            return try? decoder.decode(T.self, from: data)
        }
        
        //Caching
        cache[endpoint] = CacheObject(status: .ongoing(task))
        let response = try await task.value
        
        guard policy.shouldCache else {
            cache[endpoint] = CacheObject(status: .completed)
            return response as! T
        }
        
        cache[endpoint] = CacheObject(status: .cached(response), expiresIn: policy.shouldExpireIn)
        return response as! T
        
    }
    
    //TODO: Add -> Some sort of resposne, Kacper did not implemented it yet
    func request(to endpoint: Endpoint, authorize: Bool = true, retry: Bool = true) async throws {
        guard hasInternetConnection else { throw NetworkError.noInternetConnection }
        
        let request = authorize ? try await self.authorize(request: endpoint.request) : endpoint.request
        guard let (_, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
            throw NetworkError.invalidHTTPResponse
        }
            
        guard (200...299).contains( response.statusCode ) else {
            throw NetworkError.failure(statusCode: response.statusCode)
        }
    }
    
    func updateNetworkStatus(to status: NetworkStatus) {
        switch status {
        case .connected:
            hasInternetConnection = true
        case .disconnected:
            hasInternetConnection = false
        }
    }
    
    func clearEndpointCache(endpoint: Endpoint) {
        cache[endpoint] = nil
    }
    
    init(keychainManager: KeychainManager, cacheManager: CacheManager = CacheManager{ Date() }){
        self.cache = cacheManager
        self.keychain = keychainManager
    }
}
