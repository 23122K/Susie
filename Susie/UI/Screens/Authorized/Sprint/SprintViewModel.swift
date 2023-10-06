//
//  SprintViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import Foundation
import Factory

@MainActor
class SprintViewModel: ObservableObject {
    private var client: Client
    private var sprint: Sprint
    
    @Published var issues: Array<IssueGeneralDTO> = []
    
    func fetch() {
        Task { issues = try await client.issues(sprint: sprint) }
    }
    
    func start() {
        Task { try await client.start(sprint: sprint) }
    }
    
    @Published var name: String = String()
    @Published var isAcitve: Bool = Bool()
    @Published var date: Date = Date()
    @Published var id: Int32 = Int32()
    
    init(sprint: Sprint?, container: Container = Container.shared) {
        self.client = container.client()
        
        if let sprint {
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
