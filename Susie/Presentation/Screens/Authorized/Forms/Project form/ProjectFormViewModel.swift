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
    let projectInteractor: any ProjectInteractor
    
    @Published var project: ProjectDTO
    @Published var focus: Field?
    @Published var dismiss: Bool = .deafult
    
    enum Field: Hashable {
        case name
        case description
        case goal
    }
    
    //TODO: Remove it later, create central validation class
    private var isValid: Bool {
        !(project.name.isEmpty && project.description.isEmpty)
    }
    
    func saveProjectButtonTapped() {
        doesExist ? updateProjectActionInitiated() : createProjectActionInitiated()
        dismiss.toggle()
    }
    
    func createProjectActionInitiated() {
        Task { try await projectInteractor.create(project: project) }
    }
    
    func updateProjectActionInitiated() {
        Task { try await projectInteractor.update(project: project) }
    }
    
    func onSumbitOf(field: Field) {
        switch field {
        case .name:
            focus = .description
        case .description:
            focus = .goal
        case .goal:
            focus = .none
        }
    }
    
    init(container: Container = Container.shared, project: Project? = nil, focus: Field? = .name, dismiss: Bool = .deafult) {
        self.projectInteractor = container.projectInteractor.resolve()
        self.focus = focus
        self.dismiss = dismiss
        
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
