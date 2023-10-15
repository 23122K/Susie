//
//  Comment.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

struct Comment: Identifiable, Codable {
    let id: Int32
    let body: String
    let author: User
}

struct CommentDTO: Identifiable, Codable {
    let id: Int32
    let issueID: Int32
    let body: String
}
