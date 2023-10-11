//
//  SprintViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import Foundation
import Factory

@MainActor
class SprintsViewModel: ObservableObject {
    private var client: Client
    private var project: Project
    
    @Published var name: String = String()
    @Published var date: Date = Date()
    @Published var sprints: Array<Sprint> = []
    @Published var sprint: Sprint?
    
    @Published var issue: IssueGeneralDTO?
    
    func assign(to sprint: Sprint) {
        guard let issue else {
            print("Failed to assing")
            return
        }
            
        Task { try await client.assign(issue: issue, to: sprint) }
        
        self.issue = nil
    }
    
    func fetch() {
        print("Fetching sprints")
        Task {
            self.sprints = try await client.sprints(project: project.toDTO())
            print("Sprint count is \(self.sprints.count)")
        }
    }
    
    init(project: Project, container: Container = Container.shared) {
        self.client = container.client()
        self.project = project
    }
}
