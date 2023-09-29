//
//  ProjectViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI
import Factory

@MainActor
class ProjectsViewModel: ObservableObject {
    private var client: Client
    
    @Published var projects: Array<ProjectDTO> = .init()
    @Published var project: Project? = nil
    
    @Published var name: String = .init()
    @Published var description: String = .init()
    
    func fetch() {
        Task { self.projects = try await client.fetchProjects() }
    }
    
    func fetchDetails(of project: ProjectDTO) {
        Task { self.project = try await client.fetchProject(project: project) }
    }
    
    func delete(project: ProjectDTO) {
        Task { try await client.delete(project: project) }
        projects.removeAll(where: { $0.id == project.id })
    }
    
    init(container: Container = Container.shared) {
        self.client = container.client()
    }
}
