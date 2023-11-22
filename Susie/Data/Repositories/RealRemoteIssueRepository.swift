//
//  IssueDTORepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

class RealRemoteIssueRepository: RemoteIssueRepository, ProtectedRepository {
    var authenticationInterceptor: AuthenticationInterceptor
    
    func fetchIssuesFromSprint(_ sprint: Sprint) async throws -> IssueGeneralDTO {
        let endpoint = Endpoints.IssueEndpoint.assignedTo(sprint: sprint)
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func fetchIssuesAssignedToSignedUser() async throws -> IssueGeneralDTO {
        let endpoint = Endpoints.IssueEndpoint.userAssigned
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func fetchIssuesFromProductBacklog(project: any ProjectEntity) async throws -> IssueGeneralDTO {
        let endpoint = Endpoints.IssueEndpoint.backlog(project: project)
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func fetchArchivalIssuesFromProductBacklog(project: any ProjectEntity) async throws -> IssueGeneralDTO {
        let endpoint = Endpoints.IssueEndpoint.history(project: project)
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func update(_ issue: IssueDTO) async throws -> Issue {
        let endpoint = Endpoints.IssueEndpoint.update(issue: issue)
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func create(_ issue: IssueDTO) async throws -> Issue {
        let endpoint = Endpoints.IssueEndpoint.create(issue: issue)
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func delete(_ issue: IssueGeneralDTO) async throws {
        let endpoint = Endpoints.IssueEndpoint.delete(issue: issue)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func details(_ issue: IssueGeneralDTO) async throws -> Issue {
        let endpoint = Endpoints.IssueEndpoint.details(issue: issue)
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func unassignSignedUserFromIssue(_ issue: IssueDTO) async throws {
        let endpoint = Endpoints.IssueEndpoint.unassignFrom(issue: issue)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func assignSignedUserToIssue(_ issue: IssueDTO) async throws {
        let endpoint = Endpoints.IssueEndpoint.assignTo(issue: issue)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func updateIssueStatus(issue: IssueDTO, new status: IssueStatus) async throws {
        let endpoint = Endpoints.IssueEndpoint.change(status: status, of: issue)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    init(authenticationInterceptor: some AuthenticationInterceptor) {
        self.authenticationInterceptor = authenticationInterceptor
    }
}
