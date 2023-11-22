//
//  RemoteIssueRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol RemoteIssueRepository {
    func fetchIssuesFromSprint(_ sprint: Sprint) async throws -> IssueGeneralDTO
    func fetchIssuesAssignedToSignedUser() async throws -> IssueGeneralDTO
    func fetchIssuesFromProductBacklog(project: any ProjectEntity) async throws -> IssueGeneralDTO
    func fetchArchivalIssuesFromProductBacklog(project: any ProjectEntity) async throws -> IssueGeneralDTO
    func update(_ issue: IssueDTO) async throws -> Issue
    func create(_ issue: IssueDTO) async throws -> Issue
    func delete(_ issue: IssueGeneralDTO) async throws
    func details(_ issue: IssueGeneralDTO) async throws -> Issue
    func unassignSignedUserFromIssue(_ issue: IssueDTO) async throws
    func assignSignedUserToIssue(_ issue: IssueDTO) async throws
    func updateIssueStatus(issue: IssueDTO, new status: IssueStatus) async throws
}
