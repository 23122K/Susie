//
//  RealRemoteCommentRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

class RealRemoteCommentRepository: RemoteCommentRepository, ProtectedRepository {
    var session: URLSession
    var authenticationInterceptor: AuthenticationInterceptor
    
    func create(comment: CommentDTO) async throws {
        let endpoint = Endpoints.CommentEndpoint.post(comment: comment)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func update(comment: CommentDTO) async throws -> Comment {
        let endpoint = Endpoints.CommentEndpoint.update(comment: comment)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode(Comment.self)
    }
    
    func delete(comment: Comment) async throws {
        let endpoint = Endpoints.CommentEndpoint.delete(comment: comment)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    init(session: URLSession = URLSession.shared, authenticationInterceptor: some AuthenticationInterceptor) {
        self.session = session
        self.authenticationInterceptor = authenticationInterceptor
    }
}
