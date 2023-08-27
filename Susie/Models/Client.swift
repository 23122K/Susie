import Foundation
import SwiftUI

class Client: ObservableObject {
    private(set) var keychain: KeychainManager
    private(set) var monitor: NetworkMonitor
    private(set) var network: NetworkManager

    private var boards = ["To Do", "In progress", "In review", "Done"]
    @Published private(set) var isAuthenticated: Bool = false
    
    
    @Published var projectsDTOs: Array<ProjectDTO> = .init()
    @Published var projectsDetailed: Array<Project> = .init()
    
//    var projects: Array<Project> {
//        get async throws {
//            var newProjects = Array<Project>()
//            let projectIDs: Array<Int32> = try await fetchProjects().map { project -> Int32 in
//                return project.projectID
//            }
//
//            try await withThrowingTaskGroup(of: Project.self) { group in
//                projectIDs.forEach { id in
//                    group.addTask { return try await self.fetchProject(with: id) }
//                }
//
//                while let result = await group.nextResult() {
//                    switch result {
//                    case .success(let project):
//                        newProjects.append(project)
//                    case .failure(let error):
//                        throw error
//                    }
//                }
//            }
//
//            return newProjects
//        }
//    }
    var user: User?
    
    //MARK: Authentication/User
    func signOut() {
        isAuthenticated = false
    }
        
    func signUp(with credentials: SignUpRequest) async throws {
        print(#function)
        let endpoint = Endpoints.signUp(with: credentials)
        let _: SignUpResponse = try await network.response(from: endpoint, authorize: false, retry: false)
    }
    
    func signIn(with credentials: SignInRequest) async throws {
        print(#function)
        let endpoint = Endpoints.signIn(with: credentials)
        print(endpoint.uid)
        let response: SignInResponse = try await network.response(from: endpoint, authorize: false, retry: false)
        keychain[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        keychain[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
        isAuthenticated = true
    }
    
    func userInfo() async throws {
        print(#function)
        let endpoint = Endpoints.currentUserInfo
        print(endpoint.uid)
        let policy = CachePolicy(shouldCache: true, shouldExpireIn: 15)
        let user: User = try await network.response(from: endpoint, policy: policy)
        self.user = user
    }
    
    //MARK: Projects
    func createProject(with details: ProjectDTO) async throws {
        print(#function)
        let endpoint = Endpoints.createProject(with: details)
        let project: ProjectDTO = try await network.response(from: endpoint)
        
        projectsDTOs.append(project)
    }
    
    func fetchProjects() async throws{
        print(#function)
        let policy = CachePolicy(shouldCache: true)
        let endpoint = Endpoints.fetchProjects
        print(endpoint.uid)
        let response: Array<ProjectDTO> = try await network.response(from: endpoint, policy: policy)
        projectsDTOs = response
    }
    
    func fetchProject(with id: Int32) async throws {
        //TODO: Fix Ints in project
        print(#function)
        let id = Int(id)
        let policy = CachePolicy(shouldCache: true)
        let endpoint = Endpoints.fetchProject(id: id)
        print(endpoint.uid)
        let project: Project = try await network.response(from: endpoint, policy: policy)
        
        //TODO: Don't just append, check if exist, if not
        projectsDetailed.removeAll(where: { $0.id == project.id })
        projectsDetailed.append(project)
    }
    
    func updateProject(with details: ProjectDTO) async throws {
        print(#function)
        let endpoint = Endpoints.updateProject(with: details)
        try await network.request(to: endpoint)
        await network.clearEndpointCache(endpoint: endpoint)
        
        projectsDTOs.removeAll(where: { $0.id == details.id })
        projectsDTOs.append(details)
    }
    
    
    //TODO: Fix int casting 
    func assignToPoject(user: User, to project: ProjectDTO) async throws {
        //TODO: It does not return anything (not couting status)
        let endpoint = Endpoints.assignToProject(email: user.email, projectID: Int(project.id))
        let _ :SignInResponse = try await network.response(from: endpoint)
    }
    
    func deleteProject(with id: Int) async throws {
        let endpoint = Endpoints.deleteProject(id: id)
        try await network.request(to: endpoint)
        await network.clearEndpointCache(endpoint: endpoint)
        
        projectsDTOs.removeAll(where: { $0.id == Int32(id)})
        projectsDetailed.removeAll(where: { $0.id == Int32(id)})
    }
    
    func getBoardNames() -> Array<String> {
        return boards
    }
    
    init(keychainManager: KeychainManager = KeychainManager(), networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.keychain = keychainManager
        self.monitor = networkMonitor
        self.network = NetworkManager(keychainManager: keychain)
        
        monitor.delegate = self
        monitor.start()
    }
}


extension Client: NetworkStatusDelegate {
    func networkStatusDidChange(to status: NetworkStatus) {
        Task { await network.updateNetworkStatus(to: status) }
    }
}
