import Foundation

protocol Response: Decodable, Equatable { }
protocol Request: Encodable { }

struct VoidResponse: Response {
    
}

protocol RemoteDataProvider {
    var decoder: JSONDecoder { get }
}


class NetworkManager: ObservableObject, RemoteDataProvider {
//    private let statusOf: NSCache<NSString, ResponseObject> = NSCache()
    private let authManager: AuthManager = AuthManager()
        
    @Published private(set) var isAuthenticated: Bool = false
    
    let decoder = JSONDecoder()
    
    func authorizeRequest(request: URLRequest, needsAuthorization: Bool = true) async throws -> URLRequest {
        guard needsAuthorization else { return request }
        
        let auth = try await authManager.authorize
        var authorizedRequest = request
        authorizedRequest.setValue("Bearer \(auth.token)", forHTTPHeaderField: "Authorization")
        
        return authorizedRequest
    }
    
    func data<T: Response>(for request: URLRequest, needsAuthorization: Bool = true) async throws -> T {
        let request = try await authorizeRequest(request: request, needsAuthorization: needsAuthorization)
        
        guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
            throw NetworkManagerError.invalidHttpResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            print(response.statusCode)
            throw NetworkManagerError.failure(statusCode: response.statusCode)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    func data<T: Response>(for request: URLRequest) async throws -> Array<T> {
        guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
            throw NetworkManagerError.invalidHttpResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            throw NetworkManagerError.failure(statusCode: response.statusCode)
        }
        
        return try decoder.decode(Array<T>.self, from: data)
    }
    
    //MARK: Auth methods
    func signUp(with credentials: SignUpRequest) {
        let endpoint = Endpoints.signUp(with: credentials)
        
        Task {
            let response: SignUpResponse = try await self.data(for: endpoint.request)
        }
    }
    
    //TODO: Handle errors thrown in this function
    func signIn(with credentials: SignInRequest) {
        let endpoint = Endpoints.signIn(with: credentials)
        Task {
            let response: SignInResponse = try await self.data(for: endpoint.request, needsAuthorization: false)
            let accessToken = Auth(token: response.accessToken, expiresIn: response.expiresIn)
            let refreshToken = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
            
            do {
                try KeychainManager.insert(accessToken, for: "accessToken")
                try KeychainManager.insert(refreshToken, for: "refreshToken")
            } catch {
                signOut()
                try KeychainManager.insert(accessToken, for: "accessToken")
                try KeychainManager.insert(refreshToken, for: "refreshToken")
            }
            isAuthenticated = true
        }
    }
    
    func signOut() {
        do {
            try KeychainManager.delete(key: "accessToken")
            try KeychainManager.delete(key: "refreshToken")
        } catch {
            print(error)
        }
    }
    
    func userInfo() {
        print("XD")
        let endpoint = Endpoints.currentUserInfo
        Task {
            let response: User = try await self.data(for: endpoint.request)
            print(response.email)
        }
    }
    
    //MARK: Project methods
    func createProject(with details: ProjectDTO) {
        
        Task {
            let response: ProjectDTO = try await self.data(for: Endpoints.createProject(with: details).request)
            print(response)
        }
    }
    
    func fetchProjects() {
        Task {
            let response: Array<ProjectDTO> = try await self.data(for: Endpoints.fetchProjects.request)
            print(response)
        }
    }
    
    func fetchProject(with id: Int) {
        Task {
            let response: Project = try await self.data(for: Endpoints.fetchProject(id: id).request)
            print(response)
        }
    }
    
    func updateProject(with details: ProjectDTO) {
        Task {
            let response: ProjectDTO = try await self.data(for: Endpoints.updateProject(with: details).request)
            print(response)
        }
    }
    
    func deleteProject(with id: Int) {
        Task {
            let response: ProjectDTO = try await self.data(for: Endpoints.deleteProject(id: id).request)
            print(response)
        }
    }
    
    func assignToProject(email: String, project id: Int) {
        Task {
            let _: VoidResponse = try await self.data(for: Endpoints.assignToProject(email: email, projectID: id).request)
            print("assigned to project")
        }
    }
    //MARK: Issue methods
}

