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
    private(set) var project: ProjectDTO
    private(set) var sprint: Sprint
    
    @Published var issue: IssueGeneralDTO?
    @Published var issues: LoadingState<[IssueGeneralDTO]> = .idle
    
    func fetch() {
        self.issues = .idle
        Task {
            do {
                self.issues = .loading
                let issues = try await client.issues(sprint: sprint)
                self.issues = .loaded(issues)
            } catch {
                self.issues = .failed(error)
            }
        }
    }
    
    func start() {
        Task {
            do {
                try await client.start(sprint: sprint)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func delete() {
        Task {
            do {
                try await client.delete(sprint: sprint) 
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    init(sprint: Sprint, project: ProjectDTO, container: Container = Container.shared) {
        self.client = container.client()
        self.sprint = sprint
        self.project = project
    }
}
