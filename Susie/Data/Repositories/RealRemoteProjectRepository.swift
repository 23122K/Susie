//
//  RemoteProjectRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/11/2023.
//

import Foundation

class RealRemoteProjectRepository: RemoteProjectRepository, ProtectedRepository {
    var session: URLSession
    var authenticationInterceptor: AuthenticationInterceptor
    
    func fetch() async throws -> Array<ProjectDTO> {
        let endpoint = Endpoints.ProjectEndpoint.fetch
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode([ProjectDTO].self)
    }
    
    func update(project: ProjectDTO) async throws {
        let endpoint = Endpoints.ProjectEndpoint.update(project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func create(project: ProjectDTO) async throws {
        let endpoint = Endpoints.ProjectEndpoint.create(project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func delete(project: ProjectDTO) async throws {
        let endpoint = Endpoints.ProjectEndpoint.delete(project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func details(of project: ProjectDTO) async throws -> Project {
        let endpoint = Endpoints.ProjectEndpoint.details(project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode(Project.self)
    }
    
    func invite(user: User, to project: ProjectDTO) async throws {
        let inviteRequest = InviteRequest(email: user.email, project: project)
        let endpoint = Endpoints.ProjectEndpoint.invite(request: inviteRequest)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func remove(user: User, from project: ProjectDTO) async throws {
        let removeRequest = UserRemovalDTO(user: user, project: project)
        let endpoint = Endpoints.ProjectEndpoint.remove(request: removeRequest)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    init(session: URLSession = URLSession.shared, authenticationInterceptor: some AuthenticationInterceptor) {
        self.session = session
        self.authenticationInterceptor = authenticationInterceptor
    }
}
