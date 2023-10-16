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
    private(set) var project: ProjectDTO
    private(set) var user: User?
    private var client: Client
    
    @Published var statuses: IssueStatus = .toDo
    @Published var state: LoadingState<[IssueGeneralDTO]> = .idle
    @Published var sprint: Sprint?
    
    func fetch() {
        self.state = .idle
        Task(priority: .high) {
            do {
                state = .loading
                try await Task.sleep(nanoseconds: 500_000_000)
                if let sprint: Sprint = try? await client.active(project: project) {
                    self.sprint = sprint
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
