import Foundation
import SwiftUI

class Client: ObservableObject {
    private(set) var network: NetworkManager
    //TODO: Inject menager 
    private(set) var keychain: KeychainManager = KeychainManager()
    
    private var boards = ["To Do", "In progress", "In review", "Done"]
    @Published private(set) var isAuthenticated: Bool = false
    
    var projects: Array<Project> {
        get async throws {
            var newProjects = Array<Project>()
            let projectIDs: Array<Int32> = try await fetchProjects().map{ project -> Int32 in
                return project.projectID
            }
            
            try await withThrowingTaskGroup(of: Project.self) { group in
                projectIDs.map { id in
                    group.addTask { return try await self.fetchProject(with: id) }
                }
                
                while let result = await group.nextResult() {
                    switch result {
                    case .success(let project):
                        newProjects.append(project)
                    case .failure(let error):
                        throw error
                    }
                }
            }
            
            return newProjects
        }
    }
    
    
    //MARK: - Init
    init(networkManager: NetworkManager = NetworkManager()) {
        self.network = networkManager
        
        Task { await networkManager.startMonitoringNetwork() }
        
    }
    
    func signOut() {
        isAuthenticated = false
    }
        
    func signUp(with credentials: SignUpRequest) {
        let endpoint = Endpoints.signUp(with: credentials)
        let policy = CachePolicy(shouldCache: false)
        Task {
            let _: SignUpResponse = try await network.data(from: endpoint, authorize: false)
        }
    }
    
    func fetchProjects() async throws -> Array<ProjectDTO> {
        let endpoint = Endpoints.fetchProjects
        let response: Array<ProjectDTO> = try await network.data(from: endpoint)
        return response
    }
    
    func fetchProject(with id: Int32) async throws -> Project {
        //TODO: Fix Ints in project
        let id = Int(id)
        let endpoint = Endpoints.fetchProject(id: id)
        let response: Project = try await network.data(from: endpoint)
        return response
    }
    
    func userInfo() {
        let policy = CachePolicy(shouldCache: false)
        let endpoint = Endpoints.currentUserInfo
        Task {
            let response: User = try await network.data(from: endpoint, policy: policy)
            print(response)
        }
    }
    
    func signIn(with credentials: SignInRequest) {
        let endpoint = Endpoints.signIn(with: credentials)
        let policy = CachePolicy(shouldCache: false)
        Task {
            let response: SignInResponse = try await network.data(from: endpoint, authorize: false, retry: false, policy: policy)
            keychain[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
            keychain[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
            isAuthenticated = true
        }
    }
    
    func getBoardNames() -> Array<String> {
        return boards
    }
    
    //MARK: Observers
    
}
