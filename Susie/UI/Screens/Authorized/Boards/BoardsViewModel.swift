//
//  BoardsViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 28/09/2023.
//

import SwiftUI
import Factory

@MainActor
class BoardsViewModel: ObservableObject {
    private(set) var project: ProjectDTO
    private(set) var user: User?
    private var client: Client
    
    @Published var statuses: IssueStatus = .toDo
    @Published var issues: LoadingState<[IssueGeneralDTO]> = .idle
    @Published var sprint: Sprint?
    
    func fetch() {
        self.issues = .idle
        Task(priority: .high) {
            do {
                self.issues = .loading
                try await Task.sleep(nanoseconds: 500_000_000)
                if let sprint: Sprint = try await client.active(project: project) {
                    self.sprint = sprint
                    let issues = try await client.issues(sprint: sprint)
                    self.issues = .loaded(issues)
                } else {
                    self.issues = .loaded([])
                }
            } catch {
                self.issues = .failed(error)
            }
        }
    }
    
    func stop() {
        Task(priority: .high) {
            try await client.stop(project: project)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.fetch()
        }
    }
    
    init(container: Container = Container.shared, project: ProjectDTO) {
        self.client = container.client()
        self.user = client.user
        self.project = project
    }
}
