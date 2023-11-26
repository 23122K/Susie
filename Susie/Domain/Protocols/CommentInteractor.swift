//
//  CommentInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 25/11/2023.
//

import Foundation

protocol CommentInteractor {
    var repository: any RemoteCommentRepository { get }
}
