//
//  RealCommentInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 25/11/2023.
//

import Foundation

class RealCommentInteractor: CommentInteractor {
    var repository: RemoteCommentRepository
    
    func create(comment: CommentDTO) async throws {
        try await repository.create(comment: comment)
    }
    
    func update(comment: CommentDTO) async throws -> Comment {
        return try await repository.update(comment: comment)
    }
    
    func delete(comment: Comment) async throws {
        try await repository.delete(comment: comment)
    }
    
    init(repository: some RemoteCommentRepository) {
        self.repository = repository
    }
}
