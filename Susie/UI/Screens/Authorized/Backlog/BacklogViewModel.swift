//
//  BacklogViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI
import Factory

@MainActor
class BacklogViewModel: ObservableObject {
    private var client: Client
    private(set) var project: ProjectDTO
    private(set) var user: User?
    
    @Published var sprint: Sprint?
    @Published var issue: IssueGeneralDTO?
    @Published var draggedIssue: IssueGeneralDTO?
    
    @Published var sprints: LoadingState<[Sprint]> = .idle
    @Published var issues: LoadingState<[IssueGeneralDTO]> = .idle
    
    func fetch() {
        issues = .idle
        sprints = .idle
        
        Task(priority: .high) {
            do {
                issues = .loading
                try await Task.sleep(nanoseconds: 500_000_000)
                let issues = try await client.issues(backlog: project)
                self.issues = .loaded(issues)
            } catch {
                issues = .failed(error)
            }
        }
        
        Task(priority: .high) {
            do {
                sprints = .loading
                try await Task.sleep(nanoseconds: 500_000_000)
                let sprints = try await client.sprints(project: project)
                self.sprints = .loaded(sprints)
            } catch {
                sprints = .failed(error)
            }
        }
    }
    
    func assign(to sprint: Sprint) -> Bool {
        defer { draggedIssue = nil }
        
        guard let issue = draggedIssue else {
            return false
        }
        
        Task {
            try await client.assign(issue: issue, to: sprint)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.fetch()
        }
        
        return true
    }
    
    func delete(issue: IssueGeneralDTO) {
        Task { try await client.delete(issue: issue) }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            fetch()
        }
    }
    
    init(project: ProjectDTO, container: Container = Container.shared) {
        self.client = container.client()
        self.user = client.user
        self.project = project
    }
}
