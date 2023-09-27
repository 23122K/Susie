//
//  ProjectViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI
import Factory

@MainActor
class ProjectViewModel: ObservableObject {
    private var client: Client
    
    @Published var projectsDTOs: Array<ProjectDTO> = .init()
    @Published var projects: Array<Project> = .init()
    
    @Published var name: String = .init()
    @Published var description: String = .init()
    
    func fetch() {
        Task { try await client.fetchProjects() }
    }
    
    func fetchDetails(of project: ProjectDTO) {
        Task { try await client.fetchProject(with: project.id) }
    }
    
    func updateProject(with details: ProjectDTO) {
        let details = ProjectDTO(name: name, description: description)
        Task { try await client.updateProject(with: details) }
    }
    
    func createProject() {
        let details = ProjectDTO(name: name, description: description)
        Task { try await client.createProject(with: details) }
    }
    
    func delete(project: ProjectDTO) {
        Task { try await client.deleteProject(with: project.id)}
        
        projects.removeAll(where: { $0.id == project.id })
        projectsDTOs.removeAll(where: { $0.id == project.id })
    }
    
    init(container: Container = Container.shared) {
        self.client = container.client()
        
        client.$projectsDTOs
            .receive(on: DispatchQueue.main)
            .assign(to: &$projectsDTOs)
        
        client.$projects
            .receive(on: DispatchQueue.main)
            .assign(to: &$projects)
        
    }
}
