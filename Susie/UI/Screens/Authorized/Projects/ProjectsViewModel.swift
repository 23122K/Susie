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
    @Published var project: Project? = nil
    
    @Published var name: String = .init()
    @Published var description: String = .init()
    
    func fetch() {
        Task { self.projectsDTOs = try await client.fetchProjects() }
    }
    
    func fetchDetails(of project: ProjectDTO) {
        Task { self.project = try await client.fetchProject(with: project.id) }
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
        
        projectsDTOs.removeAll(where: { $0.id == project.id })
    }
    
    init(container: Container = Container.shared) {
        self.client = container.client()
    }
}
