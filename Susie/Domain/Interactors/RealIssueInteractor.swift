//
//  RealIssueInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 25/11/2023.
//

import Foundation

class RealIssueInteractor: IssueInteractor {
    var repository: RemoteIssueRepository
    
    func fetchIssuesFromSprint(_ sprint: Sprint) async throws -> Array<IssueGeneralDTO> {
        return try await repository.fetchIssuesFromSprint(sprint)
    }
    
    func fetchIssuesAssignedToSignedUser() async throws -> Array<IssueGeneralDTO> {
        return try await repository.fetchIssuesAssignedToSignedUser()
    }
    
    func fetchIssuesFromProductBacklog(project: Project) async throws -> Array<IssueGeneralDTO>{
        return try await repository.fetchIssuesFromProductBacklog(project: project)
    }
    
    func fetchArchivalIssuesFromProductBacklog(project: Project) async throws -> Array<IssueGeneralDTO> {
        return try await repository.fetchArchivalIssuesFromProductBacklog(project: project)
    }
    
    func update(_ issue: IssueDTO) async throws -> Issue {
        return try await repository.update(issue)
    }
    
    func create(_ issue: IssueDTO) async throws -> Issue {
        return try await repository.create(issue)
    }
    
    func delete(_ issue: IssueGeneralDTO) async throws {
        try await repository.delete(issue)
    }
    
    func details(_ issue: IssueGeneralDTO) async throws -> Issue {
        return try await repository.details(issue)
    }
    
    func unassignSignedUserFromIssue(_ issue: IssueDTO) async throws {
        try await repository.unassignSignedUserFromIssue(issue)
    }
    
    func assignSignedUserToIssue(_ issue: IssueDTO) async throws {
        try await repository.assignSignedUserToIssue(issue)
    }
    
    func updateIssueStatus(issue: IssueDTO, new status: IssueStatus) async throws {
        try await repository.updateIssueStatus(issue: issue, new: status)
    }
    
    init(repository: some RemoteIssueRepository) {
        self.repository = repository
    }
    
}
