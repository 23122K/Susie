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
    private var doesExist: Bool = false
    
    @Published var project: ProjectDTO
    
    //TODO: Remove it later, create central validation class
    private var isValid: Bool {
        !(project.name.isEmpty && project.description.isEmpty)
    }
    
    func save() { doesExist ? update() : create() }
    
    private func create() {
        Task { let _ = try await client.create(project: project) }
    }
    
    private func update() {
        Task { let _ = try await client.update(project: project) }
    }
    
    private func delete() {
        Task { let _ = try await client.delete(project: project) }
    }
    
    init(project: ProjectDTO? = nil, container: Container = Container.shared) {
        self.client = container.client()
        
        if let project {
            self.doesExist = true
            self.project = project
        } else {
            self.project = ProjectDTO(name: "", description: "", goal: nil)
        }
    }
}
