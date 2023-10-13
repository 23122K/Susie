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
    private var sprint: Sprint
    private var project: Project
    private var doesExist: Bool = false
    
    @Published var name: String = String()
    @Published var isAcitve: Bool = Bool()
    @Published var date: Date = Date()
    @Published var id: Int32 = Int32()
    
    @Published var shouldHaveStartDate: Bool = Bool()
    
    func save() {
        let sprint = Sprint(name: name, projectID: project.id, startTime: shouldHaveStartDate ? date : nil, active: false)
        switch doesExist {
        case true:
            print("Sprint should be updated") //TODO: Endpoint for sprint data updating is missing
        case false:
            Task { try await client.create(sprint: sprint)}
        }
    }
    
    init(project: Project, sprint: Sprint?, container: Container = Container.shared) {
        self.client = container.client()
        self.project = project
        
        if let sprint {
            self.doesExist = true
            self.id = sprint.id
            self.sprint = sprint
            self.name = sprint.name
            self.isAcitve = sprint.active
        } else {
            let sprint = Sprint(name: "", projectID: -1)
            self.sprint = sprint
        }
    }
}
