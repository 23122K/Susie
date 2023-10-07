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
            Task { self.user = try await info() }
        }
    }
    
    //MARK: Auth
    ///Fetches information about currently loged user
    func info() async throws -> User {
        let endpoint = Endpoints.AuthEndpoint.info
        return try await network.response(from: endpoint)
    }
    
    func signOut() async {
        await cache.flush()
        isAuthenticated = false
    }
        
    func signUp(with credentials: SignUpRequest) async throws {
        let endpoint = Endpoints.AuthEndpoint.signUp(request: credentials)
        let _: SignUpResponse = try await network.response(from: endpoint, authorize: false, retry: false)
    }
    
    func signIn(with credentials: SignInRequest) async throws {
        let endpoint = Endpoints.AuthEndpoint.signIn(request: credentials)
        let response: SignInResponse = try await network.response(from: endpoint, authorize: false, retry: false)
        
        keychain[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        keychain[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
        
        isAuthenticated = true
    }
    
    //MARK: Project
    func create(project: ProjectDTO) async throws -> ProjectDTO {
        let endpoint = Endpoints.ProjectEndpoint.create(project: project)
        return try await network.response(from: endpoint)
    }
    
    func projects() async throws -> Array<ProjectDTO>{
        let endpoint = Endpoints.ProjectEndpoint.fetch
        guard let cache = cache[endpoint], let projects = try? decoder.decode([ProjectDTO].self, from: cache.data) else {
            return try await network.response(from: endpoint, policy: CachePolicy(shouldCache: true))
        }

        return projects
    }
    
    func details(project: ProjectDTO) async throws -> Project {
        let endpoint = Endpoints.ProjectEndpoint.details(project: project)
        return try await network.response(from: endpoint)
    }
    
    func update(project: ProjectDTO) async throws -> ProjectDTO {
        let endpoint = Endpoints.ProjectEndpoint.details(project: project)
        return try await network.response(from: endpoint)
    }
    
    func invite(user: User, to project: ProjectDTO) async throws {
        let request = UserAssociationDTO(email: user.email, projectID: project.id)
        let endpoint = Endpoints.ProjectEndpoint.invite(request: request)
        let _ :SignInResponse = try await network.response(from: endpoint)
    }
    
    func delete(project: ProjectDTO) async throws {
        let endpoint = Endpoints.ProjectEndpoint.delete(project: project)
        try await network.request(to: endpoint)
    }
    
    //MARK: Dictionaries
    func statuses() async throws -> Array<IssueStatus> {
        let endpoint = Endpoints.DictionaryEndpoint.status
        return try await network.response(from: endpoint)
    }
    
    func types() async throws -> Array<IssueType> {
        let endpoint = Endpoints.DictionaryEndpoint.type
        return try await network.response(from: endpoint)
    }
    
    func priorities() async throws -> Array<IssuePriority> {
        let endpoint = Endpoints.DictionaryEndpoint.priority
        return try await network.response(from: endpoint)
    }
    
    //MARK: Issue
    func issues(project: Project) async throws -> Array<IssueGeneralDTO> {
        let endpoint = Endpoints.IssueEndpoint.fetch(project: project.toDTO())
        return try await network.response(from: endpoint)
    }
    
    func details(issue: IssueGeneralDTO) async throws -> Issue {
        let endpoint = Endpoints.IssueEndpoint.details(issue: issue)
        return try await network.response(from: endpoint)
    }
    
    func create(issue: IssueDTO) async throws -> IssueGeneralDTO {
        let endpoint = Endpoints.IssueEndpoint.create(issue: issue)
        return try await network.response(from: endpoint)
    }
    
    func update(issue: IssueDTO) async throws -> IssueGeneralDTO {
        let endpoint = Endpoints.IssueEndpoint.update(issue: issue)
        return try await network.response(from: endpoint)
    }
    
    func delete(issue: IssueGeneralDTO) async throws {
        let endpoint = Endpoints.IssueEndpoint.delete(issue: issue)
        try await network.request(to: endpoint)
    }
    
    func assign(to issue: IssueDTO) async throws {
        let endpoint = Endpoints.IssueEndpoint.assignTo(issue: issue)
        try await network.request(to: endpoint)
    }
    
    func unassign(from issue: IssueDTO) async throws {
        let endpoint = Endpoints.IssueEndpoint.unassignFrom(issue: issue)
        try await network.request(to: endpoint)
    }
    
    func status(of issue: IssueDTO, to status: IssueStatus) async throws {
        let endpoint = Endpoints.IssueEndpoint.change(status: status, of: issue)
        try await network.request(to: endpoint)
    }
    
    func issues(sprint: Sprint) async throws -> Array<IssueGeneralDTO> {
        let endpoint = Endpoints.IssueEndpoint.assignedTo(sprint: sprint)
        return try await network.response(from: endpoint)
    }
    
    func issues(backlog project: ProjectDTO) async throws -> Array<IssueGeneralDTO> {
        let endpoint = Endpoints.IssueEndpoint.backlog(project: project)
        return try await network.response(from: endpoint)
    }
    
    //MARK: Sprint
    func create(sprint: Sprint) async throws -> Sprint {
        let endpoint = Endpoints.SprintEndpoint.create(sprint: sprint)
        return try await network.response(from: endpoint)
    }
    
    func assign(issue: IssueGeneralDTO, to sprint: Sprint) async throws {
        let endpoint = Endpoints.SprintEndpoint.assign(issue: issue, to: sprint)
        try await network.request(to: endpoint)
    }
    
    func start(sprint: Sprint) async throws {
        let endpoint = Endpoints.SprintEndpoint.start(sprint: sprint)
        try await network.request(to: endpoint)
    }
    
    func stop(sprint: Sprint) async throws {
        let endpoint = Endpoints.SprintEndpoint.stop(sprint: sprint)
        try await network.request(to: endpoint)
    }
    
    func active() async throws -> Sprint {
        let endpoint = Endpoints.SprintEndpoint.ongoing
        return try await network.response(from: endpoint)
    }
    
    func sprints() async throws -> Array<Sprint> {
        let endpoint = Endpoints.SprintEndpoint.unbegun
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
