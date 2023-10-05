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
    
    func fetch() {
        Task { self.sprints = try await client.sprints() }
        print(sprints.count)
    }
    
    func create() {
        let sprint = Sprint(name: "Sprint #\(UInt8.random(in: 0..<128))", projectID: project.id, startTime: "123")
        Task {
            let sprint = try await client.create(sprint: sprint)
            self.sprints.append(sprint)
        }
    }
    
    init(project: Project, container: Container = Container.shared) {
        self.client = container.client()
        self.project = project
        
        fetch()
    }
}
