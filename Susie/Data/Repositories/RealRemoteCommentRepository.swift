//
//  RealRemoteCommentRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

class RealRemoteCommentRepository: RemoteCommentRepository, ProtectedRepository {
    var authenticationInterceptor: AuthenticationInterceptor
    
    func create(comment: CommentDTO) async throws {
        let endpoint = Endpoints.CommentEndpoint.post(comment: comment)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func update(comment: CommentDTO) async throws -> Comment {
        let endpoint = Endpoints.CommentEndpoint.update(comment: comment)
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func delete(comment: Comment) async throws {
        let endpoint = Endpoints.CommentEndpoint.delete(comment: comment)
        try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    init(authenticationInterceptor: some AuthenticationInterceptor) {
        self.authenticationInterceptor = authenticationInterceptor
    }
}
