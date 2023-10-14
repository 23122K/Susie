//
//  BoardsViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 28/09/2023.
//

import SwiftUI
import Factory

@MainActor
class BoardsViewModel: ObservableObject, AsyncDataProvider {
    
    private(set) var project: Project
    private(set) var user: User?
    private var client: Client
    
    @Published var statuses: IssueStatus = .toDo
    @Published var state: LoadingState<[IssueGeneralDTO]> = .idle
    
    func fetch() {
        self.state = .idle
        Task(priority: .high) {
            do {
                state = .loading
                if let sprint: Sprint = try? await client.active(project: project.toDTO()) {
                    let issues = try await client.issues(sprint: sprint)
                    state = .loaded(issues)
                } else {
                    //In case of no active sprint empty array is returned
                    state = .loaded([])
                }
            } catch {
                state = .failed(error)
            }
        }
    }
    
    init(container: Container = Container.shared, project: Project) {
        self.client = container.client()
        self.user = client.user
        self.project = project
    }
}
