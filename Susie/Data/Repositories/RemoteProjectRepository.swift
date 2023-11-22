//
//  RemoteProjectRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/11/2023.
//

import Foundation
import Factory

protocol ProtectedRepository {
    var authenticationInterceptor: any AuthenticationInterceptor { get }
}

class RemoteProjectDTORepository: ProjectDTORepository, ProtectedRepository {
    var authenticationInterceptor: AuthenticationInterceptor
    
    func fetch() async throws -> Array<ProjectDTO> {
        let endpoint = Endpoints.ProjectEndpoint.fetch
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func update(project: ProjectDTO) async throws {
        let endpoint = Endpoints.ProjectEndpoint.update(project: project)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func create(project: ProjectDTO) async throws {
        let endpoint = Endpoints.ProjectEndpoint.create(project: project)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func delete(project: ProjectDTO) async throws {
        let endpoint = Endpoints.ProjectEndpoint.delete(project: project)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func details(of project: ProjectDTO) async throws -> Project {
        let endpoint = Endpoints.ProjectEndpoint.details(project: project)
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func invite(user: User, to project: ProjectDTO) async throws {
        let inviteRequest = InviteRequest(email: user.email, project: project)
        let endpoint = Endpoints.ProjectEndpoint.invite(request: inviteRequest)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func remove(user: User, from project: ProjectDTO) async throws {
        let removeRequest = UserRemovalDTO(user: user, project: project)
        let endpoint = Endpoints.ProjectEndpoint.remove(request: removeRequest)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    init(authenticationInterceptor: some AuthenticationInterceptor) {
        self.authenticationInterceptor = authenticationInterceptor
    }
}
