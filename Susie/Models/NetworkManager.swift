import Foundation

protocol Response: Decodable, Equatable { }
protocol Request: Encodable { }

class NetworkManager: ObservableObject {
    
    internal enum NetworkManagerError: Error {
        case invalidHttpResponse
        case failure(statusCode: Int)
    }
    
    private var refreshToken: String?
    private var token: String? {
        willSet { isAuthenticated.toggle() }
    }
    
    
    //MARK: Variables published to model
    @Published private(set) var issues = Array<Issue>()
    @Published private(set) var projects = Array<ProjectDTO>()
    @Published private(set) var isAuthenticated = false
    @Published private(set) var error: Error?
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    internal func fetch<T: Response>(for request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkManagerError.invalidHttpResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            throw NetworkManagerError.failure(statusCode: response.statusCode)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    internal func fetch<T: Response>(for request: URLRequest) async throws -> Array<T> {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkManagerError.invalidHttpResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            throw NetworkManagerError.failure(statusCode: response.statusCode)
        }
        
        return try decoder.decode(Array<T>.self, from: data)
    }
    
    internal func fetch<T: Response>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkManagerError.invalidHttpResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            throw NetworkManagerError.failure(statusCode: response.statusCode)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    internal func fetch<T: Response>(form url: URL) async throws -> Array<T> {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkManagerError.invalidHttpResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            throw NetworkManagerError.failure(statusCode: response.statusCode)
        }
        
        return try decoder.decode(Array<T>.self, from: data)
    }
    
    //MARK: User authentication methods
    
    internal func signUp(with credentials: SignUpRequest) {
        let data = try? encoder.encode(credentials)

        if let data = data {
            let request = APIManager.request(to: .signUp, using: .POST, data: data)
            Task {
                let _: SignUpResponse = try await fetch(for: request)

                //After account has been created succesfully user is automaticly authenticated
                let credentials = SignInRequest(email: credentials.email, password: credentials.password)
                signIn(with: credentials)
            }
        }
    }
    
    internal func signIn(with credentials: SignInRequest) {
        let data = try? encoder.encode(credentials)
        
        if let data = data {
            let request = APIManager.request(to: .signIn, using: .POST, data: data)
            Task {
                let response: SignInResponse = try await fetch(for: request)
                self.token = response.accessToken
                self.refreshToken = response.refreshToken
            }
        }
    }
    
    internal func signOut() {
        token = nil
        refreshToken = nil
    }

    //MARK: Project CRUD

    internal func createProject(with details: ProjectDTO) {
        let data = try? encoder.encode(details)

        if let data = data, let token = token {
            let request = APIManager.request(to: .project, using: .POST, data: data, token: token)
            Task {
                let response: Project = try await fetch(for: request)
                print(response.name)
            }
        }
    }

    internal func fetchProjects() {
        if let token = token {
            let request = APIManager.request(to: .project, using: .GET, token: token)
            Task {
                projects = try await fetch(for: request)
            }
        }
    }

    internal func updateProject(with details: ProjectDTO) {
        let data = try? encoder.encode(details)
        
        if let data = data, let token = token {
            let request = APIManager.request(to: .project, using: .PUT, data: data, token: token)
            Task {
                let project: Project = try await fetch(for: request)
                print(project)
            }
        }
    }

    internal func deleteProject(with id: Int32) {
        if let token = token {
            let request = APIManager.request(to: .project, using: .DELETE, token: token)
        }
    }
    
    internal func assign(_ user: UserDTO, to project: ProjectDTO) {
        struct NoResponse: Response {}
        
        let userAssociation = UserAssociationDTO(email: user.email, projectID: project.projectID)
        let data = try? JSONEncoder().encode(userAssociation)
        
        if let data = data, let token = token {
            Task {
                let request = APIManager.request(to: .assignUser, using: .POST, data: data, token: token)
                let _: NoResponse = try await fetch(for: request)
                print("Assigned")
            }
        }
    }
}
