//
//  SprintFormViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/10/2023.
//

import Foundation
import Factory

class SprintFromViewModel: ObservableObject {
    let sprintInteractor: any SprintInteractor
    
    let doesExist: Bool
    
    @Published var sprint: Sprint
    @Published var startDate: Date
    @Published var shouldHaveStartDate: Bool
    @Published var shouldDismiss: Bool = false
    @Published var focus: Field?
    
    enum Field: Hashable {
        case name
        case goal
    }
    
    func onSubmitOf(field: Field) {
        switch field {
        case .name:
            self.focus = .goal
        case .goal:
            self.focus = .none
        }
    }
    
    func createSprintRequestSent(){
        Task { try await sprintInteractor.create(sprint: sprint) }
    }
    
    func updateSprintRequestSent() {
        Task { try await sprintInteractor.update(sprint: sprint) }
    }
    
    func saveSprintButtonTapped() {
        shouldHaveStartDate ? (sprint.startTime = startDate) : (sprint.startTime = nil)
        doesExist ? updateSprintRequestSent() : createSprintRequestSent()
        
        shouldDismiss.toggle()
    }
    
    init(container: Container = Container.shared, sprint: Sprint?, project: Project, startDate: Date = Date(), focus: Field? = .name) {
        self.sprintInteractor = container.sprintInteractor.resolve()
        
        self.startDate = startDate
        self.focus = focus
        
        switch sprint {
        case .none:
            self.doesExist = false
            self.sprint = Sprint(project: project)
            self.shouldHaveStartDate = false
        case let .some(sprint):
            self.doesExist = true
            self.sprint = sprint
            self.shouldHaveStartDate = sprint.hasStartDate
        }
    }
}
