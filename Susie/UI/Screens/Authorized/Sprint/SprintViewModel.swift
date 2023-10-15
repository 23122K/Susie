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
    private var project: Project
    private(set) var sprint: Sprint
    
    @Published var issues: Array<IssueGeneralDTO> = []
    @Published var issue: IssueGeneralDTO?
    
    func fetch() {
        Task { issues = try await client.issues(sprint: sprint) }
    }
    
    func start() {
        Task { try await client.start(sprint: sprint) }
    }
    
    func stop() {
        Task { try await client.stop(project: project) }
    }
    
    func delete() {
        Task { try await client.delete(sprint: sprint) }
    }
    
    init(sprint: Sprint, project: Project, container: Container = Container.shared) {
        self.client = container.client()
        self.sprint = sprint
        self.project = project
    }
}
