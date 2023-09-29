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
        let endpoint = Endpoints.AuthEndpoint.info
        let user: User = try await network.response(from: endpoint)
        self.user = user
    }
    
    //MARK: Authentication/User
    func signOut() async {
        await cache.flush()
        isAuthenticated = false
    }
        
    func signUp(with credentials: SignUpRequest) async throws {
        let endpoint = Endpoints.AuthEndpoint.signUp(request: credentials)
        let _: SignUpResponse = try await network.response(from: endpoint, authorize: false, retry: false)
    }
    
    func signIn(with credentials: SignInRequest) async throws {
        print(credentials)
        let endpoint = Endpoints.AuthEndpoint.signIn(request: credentials)
        print(endpoint.url.absoluteString)
        print(String(data: endpoint.request.httpBody!, encoding: .utf8))
        let response: SignInResponse = try await network.response(from: endpoint, authorize: false, retry: false)
        print("XDD")
        
        keychain[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        keychain[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
        
        isAuthenticated = true
    }
    
    //MARK: Projects
    func createProject(with details: ProjectDTO) async throws -> ProjectDTO {
        let endpoint = Endpoints.ProjectEndpoint.create(project: details)
        return try await network.response(from: endpoint)
    }
    
    func fetchProjects() async throws -> Array<ProjectDTO>{
        let endpoint = Endpoints.ProjectEndpoint.fetch
        guard let cache = cache[endpoint], let projects = try? decoder.decode([ProjectDTO].self, from: cache.data) else {
            return try await network.response(from: endpoint, policy: CachePolicy(shouldCache: true))
        }

        return projects
    }
    
    func fetchProject(project: ProjectDTO) async throws -> Project {
        let endpoint = Endpoints.ProjectEndpoint.details(project: project)
        return try await network.response(from: endpoint)
    }
    
    func updateProject(with details: ProjectDTO) async throws -> ProjectDTO {
        print(#function)
        let endpoint = Endpoints.ProjectEndpoint.details(project: details)
        return try await network.response(from: endpoint)
    }
    
    //TODO: Fix int casting 
    func assignToPoject(user: User, to project: ProjectDTO) async throws {
        //TODO: It does not return anything (not couting status)
        let request = UserAssociationDTO(email: user.email, projectID: project.id)
        let endpoint = Endpoints.ProjectEndpoint.invite(request: request)
        let _ :SignInResponse = try await network.response(from: endpoint)
    }
    
    func delete(project: ProjectDTO) async throws {
        let endpoint = Endpoints.ProjectEndpoint.delete(project: project)
        try await network.request(to: endpoint)
    }
    
    func fetchIssueStatusDictionary() async throws -> Array<IssueStatus> {
        let endpoint = Endpoints.DictionaryEndpoint.status
        return try await network.response(from: endpoint)
    }
    
    func fetchIssueTypesDictionary() async throws -> Array<IssueType> {
        let endpoint = Endpoints.DictionaryEndpoint.type
        return try await network.response(from: endpoint)
    }
    
    func fetchIssuePriorityDictionary() async throws -> Array<IssuePriority> {
        let endpoint = Endpoints.DictionaryEndpoint.priority
        return try await network.response(from: endpoint)
    }
    
    func fetchIssues(from project: Project) async throws -> Array<IssueGeneralDTO> {
        let endpoint = Endpoints.IssueEndpoint.fetch(project: project.toDTO())
        return try await network.response(from: endpoint)
    }
    
    func fetchIssueDetails(issue: IssueGeneralDTO) async throws -> Issue {
        let endpoint = Endpoints.IssueEndpoint.details(issue: issue)
        return try await network.response(from: endpoint)
    }
    
    func createIssue(_ details: IssueDTO) async throws -> IssueGeneralDTO {
        let endpoint = Endpoints.IssueEndpoint.create(issue: details)
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
