//
//  BacklogViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI
import Factory

@MainActor
class BacklogViewModel: ObservableObject, AsyncDataProvider {
    private var client: Client
    private(set) var project: Project
    private(set) var user: User?
    
    @Published var issue: IssueGeneralDTO?
    @Published var draggedIssue: IssueGeneralDTO?
    
    @Published var state: LoadingState<[IssueGeneralDTO]> = .idle
    
    func fetch() {
        state = .idle
        
        Task(priority: .high) {
            do {
                state = .loading
                let issues = try await client.issues(backlog: project.toDTO())
                state = .loaded(issues)
            } catch {
                state = .failed(error)
            }
        }
    }
    
    func delete(issue: IssueGeneralDTO) {
        print("Deleted")
        Task { try await client.delete(issue: issue) }
    }
    
    func edit(issue: IssueGeneralDTO) {
        print("Edited")
    }
    
    init(project: Project, container: Container = Container.shared) {
        self.client = container.client()
        self.user = client.user
        self.project = project
    }
}
