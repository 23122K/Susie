//
//  IssueDTORepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

class RealRemoteIssueRepository: RemoteIssueRepository, ProtectedRepository {
    var session: URLSession
    
    var authenticationInterceptor: AuthenticationInterceptor
    
    func fetchIssuesFromSprint(_ sprint: Sprint) async throws -> Array<IssueGeneralDTO> {
        let endpoint = Endpoints.IssueEndpoint.assignedTo(sprint: sprint)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode([IssueGeneralDTO].self)
    }
    
    func fetchIssuesAssignedToSignedUser() async throws -> Array<IssueGeneralDTO> {
        let endpoint = Endpoints.IssueEndpoint.userAssigned
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode([IssueGeneralDTO].self)
    }
    
    func fetchIssuesFromProductBacklog(project: any ProjectEntity) async throws -> Array<IssueGeneralDTO> {
        let endpoint = Endpoints.IssueEndpoint.backlog(project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode([IssueGeneralDTO].self)
    }
    
    func fetchArchivalIssuesFromProductBacklog(project: any ProjectEntity) async throws -> Array<IssueGeneralDTO> {
        let endpoint = Endpoints.IssueEndpoint.history(project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode([IssueGeneralDTO].self)
    }
    
    func update(_ issue: IssueDTO) async throws -> Issue {
        let endpoint = Endpoints.IssueEndpoint.update(issue: issue)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode(Issue.self)
    }
    
    func create(_ issue: IssueDTO) async throws -> Issue {
        let endpoint = Endpoints.IssueEndpoint.create(issue: issue)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode(Issue.self)
    }
    
    func delete(_ issue: IssueGeneralDTO) async throws {
        let endpoint = Endpoints.IssueEndpoint.delete(issue: issue)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func details(_ issue: IssueGeneralDTO) async throws -> Issue {
        let endpoint = Endpoints.IssueEndpoint.details(issue: issue)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode(Issue.self)
    }
    
    func unassignSignedUserFromIssue(_ issue: IssueDTO) async throws {
        let endpoint = Endpoints.IssueEndpoint.unassignFrom(issue: issue)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func assignSignedUserToIssue(_ issue: IssueDTO) async throws {
        let endpoint = Endpoints.IssueEndpoint.assignTo(issue: issue)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func updateIssueStatus(issue: IssueDTO, new status: IssueStatus) async throws {
        let endpoint = Endpoints.IssueEndpoint.change(status: status, of: issue)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    init(session: URLSession = URLSession.shared, authenticationInterceptor: some AuthenticationInterceptor) {
        self.session = session
        self.authenticationInterceptor = authenticationInterceptor
    }
}
