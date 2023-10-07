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
        Task {
            self.sprints = try await client.sprints()
        }
    }
    
    init(project: Project, container: Container = Container.shared) {
        self.client = container.client()
        self.project = project
    }
}
