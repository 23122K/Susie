//
//  CommentDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

struct CommentDTO: Identifiable, Codable {
    let id: Int32
    var issueID: Int32
    var body: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "commentID"
        case issueID
        case body
    }
}

extension CommentDTO {
    init(issue: IssueGeneralDTO) { self.init(id: .default, issueID: issue.id, body: .default) }
}
