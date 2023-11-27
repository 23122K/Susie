//
//  ProjectFormViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI
import Factory

@MainActor
class ProjectFormViewModel: ObservableObject {
    let doesExist: Bool
    
    let projectInteractor: RealProjectInteractor
    
    @Published var project: ProjectDTO
    
    //TODO: Remove it later, create central validation class
    private var isValid: Bool {
        !(project.name.isEmpty && project.description.isEmpty)
    }
    
    func saveProjectButtonTapped() { doesExist ? updateProjectActionInitiated() : createProjectActionInitiated() }
    
    func createProjectActionInitiated() {
        Task { try await projectInteractor.create(project: project) }
    }
    
    func updateProjectActionInitiated() {
        Task { try await projectInteractor.update(project: project) }
    }
    
    init(container: Container = Container.shared, project: Project? = nil) {
        self.projectInteractor = container.projectInteractor.resolve()
        
        switch project {
        case .none:
            self.doesExist = false
            self.project = ProjectDTO()
        case let .some(project):
            self.doesExist = true
            self.project = project.toDTO()
        }
    }
}
