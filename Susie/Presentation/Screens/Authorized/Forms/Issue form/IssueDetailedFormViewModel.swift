//
//  IssueDetailedFormViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 19/10/2023.
//

import Factory
import Foundation

@MainActor
class IssueDetailedFormViewModel: ObservableObject {
    var status: IssueStatus
    
    let issueInteractor: any IssueInteractor
    
    @Published var issue: Issue { didSet { changeStatusActionInitated() } }
    @Published var destination: Destination?
    
    enum Destination: Identifiable, Hashable {
        var id: Self { self }
        
        case priority
        case type
        case status
    }
    
    private func changeStatusActionInitated() {
        guard issue.status != status else { return }
        Task { try await issueInteractor.updateIssueStatus(issue: issue.toDTO(), new: issue.status) }
    }
    
    func updateIssueDetailsButtonTapped() {
        Task { try await issueInteractor.update(issue.toDTO()) }
    }
    
    func assignToIssueButtonTapped() {
        Task { try await issueInteractor.assignSignedUserToIssue(issue.toDTO()) }
    }
    
    func unassignFromIssueButtonTapped() {
        Task { try await issueInteractor.unassignSignedUserFromIssue(issue.toDTO()) }
    }
    
    func destinationButtonTapped(for destination: Destination) {
        self.destination = destination
    }
    
    func dismissDestintationButtonTapped() {
        self.destination = .none
    }
    
    init(container: Container = Container.shared, issue: Issue, destination: Destination? = nil) {
        self.issueInteractor = container.issueInteractor.resolve()
        
        self.status = issue.status
        self.destination = destination
        _issue = Published(initialValue: issue)
    }
}
