//
//  SprintViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import Foundation
import Factory

class SprintViewModel: ObservableObject {
    private var client: Client
    private var sprint: Sprint
    
    @Published var name: String = String()
    @Published var isAcitve: Bool = Bool()
    @Published var date: String = String()
    init(sprint: Sprint?, container: Container = Container.shared) {
        self.client = container.client()
        
        if let sprint {
            self.sprint = sprint
            self.name = sprint.name
            self.isAcitve = sprint.active
            self.date = sprint.startTime ?? "Unknown date"
        } else {
            let sprint = Sprint(name: "", projectID: -1)
            self.sprint = sprint
        }
    }
}
