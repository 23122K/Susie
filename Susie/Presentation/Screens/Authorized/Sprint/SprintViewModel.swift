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
    let sprint: Sprint
    let project: Project
    
    let issueInteractor: RealIssueInteractor
    let sprintInteractor: RealSprintInteractor
    
    @Published var issue: IssueGeneralDTO?
    @Published var issues: Loadable<[IssueGeneralDTO]> = .idle
    
    func fetchSprints() {
        Task {
            do {
                self.issues = .loading
                let issues = try await issueInteractor.fetchIssuesFromSprint(sprint)
                self.issues = .loaded(issues)
            } catch {
                self.issues = .failed(error)
            }
        }
    }
    
    func startSprintButtonTapped() {
        Task {
            do {
                try await sprintInteractor.startSprint(sprint: sprint)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteSprintButtonTapped() {
        Task {
            do {
                try await sprintInteractor.delete(sprint: sprint)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    init(container: Container = Container.shared,
         sprint: Sprint,
         project: Project,
         issue: IssueGeneralDTO? = .none,
         issues: Loadable<[IssueGeneralDTO]> = .idle
    ) {
        self.issueInteractor = container.issueInteractor.resolve()
        self.sprintInteractor = container.sprintInteractor.resolve()
        
        self.sprint = sprint
        self.project = project
        self.issues = issues
        self.issues = issues
    }
}
