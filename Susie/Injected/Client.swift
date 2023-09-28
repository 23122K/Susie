import Foundation
import SwiftUI

class Client: ObservableObject {
    private(set) var cache: CacheManager
    private(set) var keychain: KeychainManager
    private(set) var monitor: NetworkMonitor
    private(set) var network: NetworkManager
    
    private var decoder: JSONDecoder = JSONDecoder()

    private(set) var networkStatus: NetworkStatus = .connected
    
    @Published private(set) var user: User?
    @Published private(set) var scope: UserScope = .none
    @Published private(set) var isAuthenticated: Bool = false {
        willSet {
            Task { try await userInfo() }
        }
    }
    
    func userInfo() async throws {
        let endpoint = Endpoints.currentUserInfo
        let user: User = try await network.response(from: endpoint)
        self.user = user
    }
    
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
    
    //MARK: Projects
    func createProject(with details: ProjectDTO) async throws -> ProjectDTO {
        let endpoint = Endpoints.createProject(with: details)
        return try await network.response(from: endpoint)
    }
    
    func fetchProjects() async throws -> Array<ProjectDTO>{
        let endpoint = Endpoints.fetchProjects
        guard let cache = cache[endpoint], let projects = try? decoder.decode([ProjectDTO].self, from: cache.data) else {
            return try await network.response(from: endpoint, policy: CachePolicy(shouldCache: true))
        }

        return projects
    }
    
    func fetchProject(with id: Int32) async throws -> Project {
        let endpoint = Endpoints.fetchProject(id: id)
        return try await network.response(from: endpoint)
        
        //TODO: Don't just append, check if exist, if not
//        projects.removeAll(where: { $0.id == project.id })
//        projects.append(project)
    }
    
    func updateProject(with details: ProjectDTO) async throws {
        print(#function)
        let endpoint = Endpoints.updateProject(with: details)
        try await network.request(to: endpoint)
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
    }
    
    func fetchIssueStatusDictionary() async throws -> Array<IssueStatus> {
        let endpoint = Endpoints.fetchIssueStatusDictionary
        return try await network.response(from: endpoint)
    }
    
    func fetchIssueTypesDictionary() async throws -> Array<IssueType> {
        let endpoint = Endpoints.fetchIssueTypeDictionary
        return try await network.response(from: endpoint)
    }
    
    func fetchIssuePriorityDictionary() async throws -> Array<IssuePriority> {
        let endpoint = Endpoints.fetchIssuePriorityDictionary
        return try await network.response(from: endpoint)
    }
    
    func fetchIssues(from project: Project) async throws -> Array<IssueGeneralDTO> {
        let endpoint = Endpoints.fetchIssues(id: project.id)
        return try await network.response(from: endpoint)
    }
    
    func fetchIssueDetails(issue: IssueGeneralDTO) async throws -> Issue {
        let endpoint = Endpoints.fetchIssueDetails(id: issue.id)
        return try await network.response(from: endpoint)
    }
    
    func createIssue(_ details: IssueDTO) async throws -> IssueGeneralDTO {
        let endpoint = Endpoints.createIssue(with: details)
        return try await network.response(from: endpoint)
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
