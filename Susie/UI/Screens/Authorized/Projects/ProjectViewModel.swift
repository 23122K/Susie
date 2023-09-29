//
//  ProjectFormViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI
import Factory

@MainActor
class ProjectViewModel: ObservableObject {
    private var client: Client
    
    @Published var name: String
    @Published var description: String
    
    private var shoudUpdate = false
    private var project: ProjectDTO
    
    //TODO: Remove it later, create central validation class
    private var isValid: Bool {
        !(project.name.isEmpty && project.description.isEmpty)
    }
    
    func save() { shoudUpdate ? update() : create() }
    
    private func create() {
        let project = ProjectDTO(name: name, description: description)
        Task { let _ = try await client.createProject(with: project) }
    }
    
    private func update() {
        let project = ProjectDTO(id: project.id, name: name, description: description)
        Task { let _ = try await client.updateProject(with: project) }
    }
    
    private func delete() {
        Task { let _ = try await client.delete(project: project) }
    }
    
    init(project: ProjectDTO? = nil, container: Container = Container.shared) {
        self.client = container.client()
        
        if let project {
            self.shoudUpdate = true
            self.project = project
            self.name = project.name
            self.description = project.description
        } else {
            self.project = ProjectDTO(name: String(), description: String())
            self.name = self.project.name
            self.description = self.project.description
        }
    }
}
