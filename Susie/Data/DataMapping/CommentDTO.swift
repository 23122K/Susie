//
//  CommentDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

class CommentDTO: Identifiable, Codable {
    let id: Int32
    var issueID: Int32
    var body: String
    
    enum CodingKeys: String, CodingKey {
        case id = "commentID"
        case issueID
        case body
    }
    
    init(id: Int32, issue: IssueGeneralDTO, body: String) {
        self.id = id
        self.issueID = issue.id
        self.body = body
    }
    
    convenience init(issue: IssueGeneralDTO, body: String) {
        self.init(id: -1, issue: issue, body: body)
    }
}
