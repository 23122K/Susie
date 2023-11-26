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
    let project: Project
    let user: User
    
    let issueInteractor: RealIssueInteractor
    let sprintInteractor: RealSprintInteractor
    
    @Published var sprint: Sprint?
    @Published var issue: IssueGeneralDTO?
    @Published var draggedIssue: IssueGeneralDTO?
    
    @Published var sprints: Loadable<[Sprint]> = .idle
    @Published var issues: Loadable<[IssueGeneralDTO]> = .idle
    
    @Published var dropStatus: DropStatus = .exited
    
    enum DropStatus {
        case entered
        case exited
    }
    
    func onDragIssueGesture(issue: IssueGeneralDTO) -> NSItemProvider {
        draggedIssue = issue
        return NSItemProvider()
    }

    func fetchInactiveSprints(project: Project) async {
        do {
            sprints = .loading
            let sprints = try await sprintInteractor.fetchInactiveSprints(project: project.toDTO())
            self.sprints = .loaded(sprints)
        } catch { sprints = .failed(error) }
    }
    
    func fetchInactiveIssues(project: Project) async {
        do {
            issues = .loading
            let issues = try await issueInteractor.fetchIssuesFromProductBacklog(project: project.toDTO())
            self.issues = .loaded(issues)
        } catch { issues = .failed(error) }
    }
    
    func fetchInactiveSprintsAndIssues() {
        Task {
            await fetchInactiveSprints(project: project)
            await fetchInactiveIssues(project: project)
        }
    }
    
    func assignIssue(to sprint: Sprint) -> Bool {
        guard let issue = draggedIssue else { return false }
        
        Task {
            try await sprintInteractor.assignIssueToSprint(issue: issue, sprint: sprint)
            self.draggedIssue = nil
        }
        
        return true
    }
    
    func deleteIssueButtonTapped(issue: IssueGeneralDTO) {
        Task { try await issueInteractor.delete(issue) }
    }
    
    
    init(project: Project, user: User, container: Container = Container.shared) {
        self.project = project
        self.user = user
        self.issueInteractor = container.issueInteractor.resolve()
        self.sprintInteractor = container.sprintInteractor.resolve()
    }
}
