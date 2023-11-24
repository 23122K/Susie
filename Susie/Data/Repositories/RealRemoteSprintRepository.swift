//
//  RealRemoteSprintRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

class RealRemoteSprintRepository: RemoteSprintRepository, ProtectedRepository {
    var session: URLSession
    var authenticationInterceptor: AuthenticationInterceptor
    
    func update(sprint: Sprint) async throws -> Sprint{
        let endpoint = Endpoints.SprintEndpoint.update(sprint: sprint)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode(Sprint.self)
    }
    
    func create(sprint: Sprint) async throws -> Sprint {
        let endpoint = Endpoints.SprintEndpoint.create(sprint: sprint)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode(Sprint.self)
    }
    
    func delete(sprint: Sprint) async throws {
        let endpoint = Endpoints.SprintEndpoint.delete(sprint: sprint)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func assignIssueToSprint(issue: IssueGeneralDTO, sprint: Sprint) async throws {
        let endpoint = Endpoints.SprintEndpoint.assign(issue: issue, to: sprint)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func removeIssueFromSprint(issue: IssueGeneralDTO, sprint: Sprint) async throws {
        let endpoint = Endpoints.SprintEndpoint.unassign(issue: issue, from: sprint)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func startSprint(sprint: Sprint) async throws {
        let endpoint = Endpoints.SprintEndpoint.start(sprint: sprint)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func stopSprint(project: ProjectDTO) async throws {
        let endpoint = Endpoints.SprintEndpoint.stop(project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func fetchInactiveSprints(project: ProjectDTO) async throws -> Array<Sprint> {
        let endpoint = Endpoints.SprintEndpoint.unbegun(project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode([Sprint].self)
    }
    
    func fetchActiveSprint(project: ProjectDTO) async throws -> Sprint? {
        let endpoint = Endpoints.SprintEndpoint.ongoing(project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode(Sprint?.self)
    }
    
    init(session: URLSession = URLSession.shared, authenticationInterceptor: some AuthenticationInterceptor) {
        self.session = session
        self.authenticationInterceptor = authenticationInterceptor
    }
}
