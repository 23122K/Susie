import Foundation
import SwiftUI

class Client: ObservableObject {
    private(set) var cache: CacheManager
    private(set) var keychain: KeychainManager
    private(set) var monitor: NetworkMonitor
    private(set) var network: NetworkManager
    
    private var decoder: JSONDecoder = JSONDecoder()

    private(set) var networkStatus: NetworkStatus = .connected
    private var boards = ["To Do", "In progress", "In review", "Done"]
    
    @Published private(set) var isAuthenticated: Bool = false {
        willSet {
            Task { try await userInfo() }
        }
    }
    
    @Published private(set) var projectsDTOs: Array<ProjectDTO> = .init()
    @Published private(set) var projects: Array<Project> = .init()
    
    var user: User?
    
    //MARK: Authentication/User
    func signOut() async {
        await cache.flush()
        isAuthenticated = false
    }
        
    func signUp(with credentials: SignUpRequest) async throws {
        let endpoint = Endpoints.signUp(with: credentials)
        let _: SignUpResponse = try await network.response(from: endpoint, authorize: false, retry: false)
    }
    
    func signIn(with credentials: SignInRequest) async throws {
        let endpoint = Endpoints.signIn(with: credentials)
        let response: SignInResponse = try await network.response(from: endpoint, authorize: false, retry: false)
        
        keychain[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        keychain[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
        
        isAuthenticated = true
    }
    
    func userInfo() async throws {
        let endpoint = Endpoints.currentUserInfo
        let user: User = try await network.response(from: endpoint)
        self.user = user
    }
    
    //MARK: Projects
    func createProject(with details: ProjectDTO) async throws {
        print(#function)
        let endpoint = Endpoints.createProject(with: details)
        let project: ProjectDTO = try await network.response(from: endpoint)
        
        projectsDTOs.append(project)
    }
    
    func fetchProjects() async throws {
        let endpoint = Endpoints.fetchProjects
        guard let cache = cache[endpoint], let projects = try? decoder.decode([ProjectDTO].self, from: cache.data) else {
            projectsDTOs = try await network.response(from: endpoint, policy: CachePolicy(shouldCache: true))
            print("Projects fetched from server")
            return
        }

        print("Project fetched from cache")
        projectsDTOs = projects
    }
    
    func fetchProject(with id: Int32) async throws {
        //TODO: Fix Ints in project
        print(#function)
        let endpoint = Endpoints.fetchProject(id: id)
        print(endpoint.uid)
        let project: Project = try await network.response(from: endpoint)
        
        //TODO: Don't just append, check if exist, if not
        projects.removeAll(where: { $0.id == project.id })
        projects.append(project)
    }
    
    func updateProject(with details: ProjectDTO) async throws {
        print(#function)
        let endpoint = Endpoints.updateProject(with: details)
        try await network.request(to: endpoint)
        
        projectsDTOs.removeAll(where: { $0.id == details.id })
        projectsDTOs.append(details)
    }
    
    
    //TODO: Fix int casting 
    func assignToPoject(user: User, to project: ProjectDTO) async throws {
        //TODO: It does not return anything (not couting status)
        let endpoint = Endpoints.assignToProject(email: user.email, projectID: project.id)
        let _ :SignInResponse = try await network.response(from: endpoint)
    }
    
    func deleteProject(with id: Int32) async throws {
        let endpoint = Endpoints.deleteProject(id: id)
        try await network.request(to: endpoint)
        
        projectsDTOs.removeAll(where: { $0.id == id})
        projects.removeAll(where: { $0.id == id})
    }
    
    func getBoardNames() -> Array<String> {
        return boards
    }
    
    init(keychainManager: KeychainManager = KeychainManager(),
         cacheManager: CacheManager = CacheManager(dateProvider: { Date() }),
         networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.keychain = keychainManager
        self.cache = cacheManager
        self.monitor = networkMonitor
        self.network = NetworkManager(keychainManager: keychain, cacheManager: cacheManager)
        
        monitor.delegate = self
        monitor.start()
    }
}


extension Client: NetworkStatusDelegate {
    func networkStatusDidChange(to status: NetworkStatus) {
        Task {
            networkStatus = status
            cache.updateNetworkStatus(to: status)
        }
    }
}
