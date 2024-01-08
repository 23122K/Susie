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
    
    let issueInteractor: any IssueInteractor
    let sprintInteractor: any SprintInteractor
    
    @Published var destination: Destination?
    @Published var dropStatus: DropStatus
    @Published var draggedIssue: IssueGeneralDTO?
    @Published var sprints: Loadable<[Sprint]>
    @Published var issues: Loadable<[IssueGeneralDTO]>
    
    
    enum DropStatus {
        case entered
        case exited
    }
    
    enum Destination: Identifiable, Hashable {
        var id: Self { self }
        
        case details(Sprint)
        case edit(IssueGeneralDTO)
    }
    
    func onDragIssueGesture(issue: IssueGeneralDTO) -> NSItemProvider {
        draggedIssue = issue
        return NSItemProvider()
    }

    func fetchInactiveSprints(project: Project) async {
        do {
            sprints = .loading
            let sprints = try await sprintInteractor.fetchInactiveSprints(project: project)
            self.sprints = .loaded(sprints)
        } catch { sprints = .failed(error) }
    }
    
    func fetchInactiveIssues(project: Project) async {
        do {
            issues = .loading
            let issues = try await issueInteractor.fetchIssuesFromProductBacklog(project: project)
            self.issues = .loaded(issues)
        } catch { issues = .failed(error) }
    }
    
    func onAppear() {
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
    
    func destinationButtonTapped(for destination: Destination) {
        self.destination = destination
    }
    
    init(
        container: Container = Container.shared,
        project: Project,
        user: User,
        dropStatus: DropStatus = .exited,
        destination: Destination? = .none,
        draggedIssue: IssueGeneralDTO? = .none,
        sprints: Loadable<[Sprint]> = .idle,
        issues: Loadable<[IssueGeneralDTO]> = .idle
    ) {
        self.issueInteractor = container.issueInteractor.resolve()
        self.sprintInteractor = container.sprintInteractor.resolve()
        
        self.project = project
        self.user = user
        self.destination = destination
        self.dropStatus = dropStatus
        self.draggedIssue = draggedIssue
        self.sprints = sprints
        self.issues = issues
    }
}
