//
//  RemoteCommentRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol RemoteCommentRepository {
    func create(comment: CommentDTO) async throws
    func update(comment: CommentDTO) async throws -> Comment
    func delete(comment: Comment) async throws
}
