//
//  CommentInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 25/11/2023.
//

import Foundation

protocol CommentInteractor {
    var repository: any RemoteCommentRepository { get }
    
    func create(comment: CommentDTO) async throws
    func update(comment: CommentDTO) async throws -> Comment
    func delete(comment: Comment) async throws
}
