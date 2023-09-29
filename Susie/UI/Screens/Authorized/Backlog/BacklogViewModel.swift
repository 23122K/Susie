//
//  BacklogViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI
import Factory

class BacklogViewModel: ObservableObject {
    private var project: ProjectDTO
    private var client: Client
    
    internal enum Entity {
        case sprint
        case issue
    }
    
    @Published var sprints: Array<Sprint> = []
    @Published var issues: Array<Issue> = []
    
//    func get(_ entity: Entity) {
//        switch entity {
//        case .issue: Task { self.issues = try await client.fetchIssues(from: project)}
//        case .sprint: Task { self.sprints = try await client.fet}
//        }
//    }
//
    init(project: ProjectDTO, container: Container = Container.shared) {
        self.client = container.client()
        self.project = project
    }
}
