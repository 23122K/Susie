import Foundation

protocol Response: Decodable, Equatable { }
protocol Request: Encodable { }

struct VoidResponse: Response {
    
}

protocol RemoteDataProvider {
    var decoder: JSONDecoder { get }
    func data<T: Response>(for request: URLRequest) async throws -> T
    func data<T: Response>(for request: URLRequest) async throws -> Array<T>
}


class NetworkManager: ObservableObject, RemoteDataProvider {
//    private let statusOf: NSCache<NSString, ResponseObject> = NSCache()
    
    private var refreshToken: String?
    private var token: String? {
        didSet { isAuthenticated = true }
    }
    
    
    @Published private(set) var isAuthenticated: Bool = false
    
    let decoder = JSONDecoder()
    
    func data<T: Response>(for request: URLRequest) async throws -> T {
        guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
            throw NetworkManagerError.invalidHttpResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
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
    
    func signIn(with credentials: SignInRequest) {
        let endpoint = Endpoints.signIn(with: credentials)
        Task {
            let response: SignInResponse = try await self.data(for: endpoint.request)
            self.token = response.accessToken
            self.refreshToken = response.refreshToken
        }
    }
    
    func signOut() {
        token = nil
        refreshToken = nil
    }
    
    func userInfo() async {
        guard let token = token else {
            print("Token not found")
            return
        }
        
        let endpoint = Endpoints.currentUserInfo(token: token)
        Task {
            let response: User = try await self.data(for: endpoint.request)
            return response
        }
    }
    
    //MARK: Project methods
    func createProject(with details: ProjectDTO) {
        guard let token = token else {
            print("Token not found")
            return
        }
        
        Task {
            let response: ProjectDTO = try await self.data(for: Endpoints.createProject(with: details, token: token).request)
            print(response)
        }
    }
    
    func fetchProjects() {
        guard let token = token else {
            print("Token not found")
            return
        }
        
        Task {
            let response: Array<ProjectDTO> = try await self.data(for: Endpoints.fetchProjects(token: token).request)
            print(response)
        }
    }
    
    func fetchProject(with id: Int) {
        guard let token = token else {
            print("Token not found")
            return
        }
        
        Task {
            let response: Project = try await self.data(for: Endpoints.fetchProject(id: id, token: token).request)
            print(response)
        }
    }
    
    func updateProject(with details: ProjectDTO) {
        guard let token = token else {
            print("Token not found")
            return
        }
        
        Task {
            let response: ProjectDTO = try await self.data(for: Endpoints.updateProject(with: details, token: token).request)
            print(response)
        }
    }
    
    func deleteProject(with id: Int) {
        guard let token = token else {
            print("Token not found")
            return
        }
        
        Task {
            let response: ProjectDTO = try await self.data(for: Endpoints.deleteProject(id: id, token: token).request)
            print(response)
        }
    }
    
    func assignToProject(email: String, project id: Int) {
        guard let token = token else {
            print("Token not found")
            return
        }
        
        Task {
            let _: VoidResponse = try await self.data(for: Endpoints.assignToProject(email: email, projectID: id, token: token).request)
            print("assigned to project")
        }
    }
    
    //MARK: Issue methods
}

