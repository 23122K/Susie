//
//  Comment.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

class Comment: Identifiable, Codable {
    let id: Int32
    var body: String
    var author: User
    
    enum CodingKeys: String, CodingKey {
        case id = "commentID"
        case body
        case author
    }
}
