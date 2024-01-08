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
    let user: User
    let project: Project
    
    let projectInteractor: any ProjectInteractor
    let issueInteractor: any IssueInteractor
    let sprintInteractor: any SprintInteractor
    
    @Published var issues: Loadable<[IssueGeneralDTO]>
    @Published var sprint: Sprint?
    
    func fetchIssuesAssignedToActiveSprint() {
        Task(priority: .high) {
            do {
                self.issues = .loading
                try await Task.sleep(nanoseconds: 500_000_000)
                if let sprint = try? await sprintInteractor.fetchActiveSprint(project: project) {
                    self.sprint = sprint
                    let issues = try await issueInteractor.fetchIssuesFromSprint(sprint)
                    self.issues = .loaded(issues)
                } else {
                    self.sprint = nil
                    self.issues = .loaded([])
                }
            } catch {
                self.issues = .failed(error)
            }
        }
    }
    
    func stopSprintButtonTapped() {
        Task { try await sprintInteractor.stopSprint(project: project) }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.fetchIssuesAssignedToActiveSprint()
        }
    }
    
    init(container: Container = Container.shared,
         project: Project,
         user: User,
         issues: Loadable<[IssueGeneralDTO]> = .idle,
         sprint: Sprint? = .none
    ) {
        self.projectInteractor = container.projectInteractor.resolve()
        self.issueInteractor = container.issueInteractor.resolve()
        self.sprintInteractor = container.sprintInteractor.resolve()
        
        self.project = project
        self.user = user
        self.issues = issues
        self.sprint = sprint
    }
}
