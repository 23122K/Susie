//
//  SprintFormViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/10/2023.
//

import Foundation
import Factory

class SprintFromViewModel: ObservableObject {
    private var client: Client
    private(set) var doesExist: Bool = false
    
    @Published var sprint: Sprint
    @Published var shouldHaveStartDate: Bool = false
    @Published var startDate: Date = Date()
    
    func save() {
        shouldHaveStartDate ? (sprint.startTime = startDate) : (sprint.startTime = nil)
        
        switch doesExist {
        case true:
            Task { try await client.update(sprint: sprint) }
        case false:
            Task { try await client.create(sprint: sprint) }
        }
    }
    
    init(sprint: Sprint?, project: ProjectDTO, container: Container = Container.shared) {
        self.client = container.client()
        
        if let sprint {
            self.doesExist = true
            self.sprint = sprint
            
            if sprint.hasStartDate { shouldHaveStartDate = true }
            
        } else {
            self.sprint = Sprint(name: "", projectID: project.id, goal: "")
        }
    }
}
