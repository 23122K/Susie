import SwiftUI

@MainActor
class ClientViewModel: ObservableObject {
    @Injected(\.client) var client

    @Published var isAuthenticated = false
    @Published var issues = Array<Issue>()
    @Published var sprints = Array<Sprint>()
    @Published var projects = Array<Project>()
    
    init(){
        client.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .assign(to: &$isAuthenticated)
    }
                
    func fetchProjects() {
        Task {
            let updatedProjects = try await client.projects
            self.projects = updatedProjects
        }
    }
    
    func signIn(with credentials: SignInRequest){
        client.signIn(with: credentials)
    }
    
    func getBoardNames() -> Array<String> {
        client.getBoardNames()
    }
    
    func userInfo() {
        client.userInfo()
    }
    
}

