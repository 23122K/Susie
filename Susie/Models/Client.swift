import Foundation

class Model: ObservableObject {
    private(set) var networkManager: NetworkManager
    
    private var boards = ["To Do", "In progress", "In review", "Done"]
    
    @Published private(set) var isAuthenticated: Bool = false
    @Published private(set) var sprints = Array<Sprint>()
    @Published private(set) var issues = Array<Issue>()
    
    
    //MARK: - Init
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func signOut() {
        isAuthenticated = false
    }
    
    func signUp(with credentials: SignUpRequest) {
        let endpoint = Endpoints.signUp(with: credentials)
        Task {
            let _: SignUpResponse = try await networkManager.data(from: endpoint, authorize: false)
        }
    }
    
    func fetchProjects() {
        let endpoint = Endpoints.fetchProjects
        Task {
            let response: [ProjectDTO] = try await networkManager.data(from: endpoint)
            print(response)
        }
    }
    
    func userInfo() {
        let endpoint = Endpoints.currentUserInfo
        Task {
            let response: User = try await networkManager.data(from: endpoint)
            print(response)
        }
    }
    
    func signIn(with credentials: SignInRequest) {
        let endpoint = Endpoints.signIn(with: credentials)
        Task {
            let response: SignInResponse = try await networkManager.data(from: endpoint, authorize: false, retry: false)
            do {
                try KeychainManager.insert(Auth(token: response.accessToken, expiresIn: response.expiresIn), for: .accessToken)
                try KeychainManager.insert(Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn), for: .refreshToken)
                isAuthenticated.toggle()
            } catch KeychainError.authObjectExists {
                try KeychainManager.delete(key: .accessToken)
                try KeychainManager.delete(key: .refreshToken)
            }
            
        }
    }
    
    func getBoardNames() -> Array<String> {
        return boards
    }
    
    
}
