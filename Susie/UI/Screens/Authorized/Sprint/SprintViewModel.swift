//
//  SprintViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import Foundation
import Factory

@MainActor
class SprintViewModel: ObservableObject, AsyncDataProvider {
    private var client: Client
    private(set) var project: ProjectDTO
    private(set) var sprint: Sprint
    
    @Published var issue: IssueGeneralDTO?
    @Published var state: LoadingState<[IssueGeneralDTO]> = .idle
    
    func fetch() {
        state = .idle
        Task {
            do {
                state = .loading
                let issues = try await client.issues(sprint: sprint)
                state = .loaded(issues)
            } catch {
                state = .failed(error)
            }
        }
    }
    
    func start() {
        Task {
            do {
                try await client.start(sprint: sprint)
            } catch {
                print(error.localizedDescription)
                state = .failed(error)
            }
        }
    }
    
    func delete() {
        Task {
            do {
                try await client.delete(sprint: sprint) 
            } catch {
                state = .failed(error)
            }
        }
    }
    
    init(sprint: Sprint, project: ProjectDTO, container: Container = Container.shared) {
        self.client = container.client()
        self.sprint = sprint
        self.project = project
    }
}
