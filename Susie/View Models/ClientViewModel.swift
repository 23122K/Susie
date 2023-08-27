import SwiftUI

@MainActor
class ClientViewModel: ObservableObject {
    @Injected(\.client) var client

    @Published var isAuthenticated = false
    @Published var issues = Array<Issue>()
    @Published var sprints = Array<Sprint>()
    @Published var projectDTOs = Array<ProjectDTO>()
    @Published var projects = Array<Project>()
    
    init(){
        client.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .assign(to: &$isAuthenticated)
        
        client.$projectsDetailed
            .receive(on: DispatchQueue.main)
            .assign(to: &$projects)
        
        client.$projectsDTOs
            .receive(on: DispatchQueue.main)
            .assign(to: &$projectDTOs)
    }
                
    func fetchProjects() {
        Task {
            try await client.fetchProjects()
//            projectDTOs = client.projectsDTOs
        }
    }
    
    func updateProject(with details: ProjectDTO) {
        Task {
            try await client.updateProject(with: details)
//            projectDTOs = client.projectsDTOs
        }
    }
    
    func createProject(with details: ProjectDTO) {
        Task { try await client.createProject(with: details) }
    }
    
    func delete(project: ProjectDTO) {
        Task {
            try await client.deleteProject(with: Int(project.id))
//            projectDTOs = client.projectsDTOs
//            projects = client.projectsDetailed
        }
    }
    
    func fetchDetails(of project: ProjectDTO) {
        Task {
            try await client.fetchProject(with: project.id)
//            projects = client.projectsDetailed
        }
    }
    
    func signIn(with credentials: SignInRequest){
        Task {
            try await client.signIn(with: credentials)
        }
    }
    
    func getBoardNames() -> Array<String> {
        client.getBoardNames()
    }
    
    func userInfo() {
        Task {
            try await client.userInfo()
        }
    }
    
}

