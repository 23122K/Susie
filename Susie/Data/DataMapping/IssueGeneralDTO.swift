//
//  IssueGeneralDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

struct IssueGeneralDTO: Identifiable, Codable {
    let id: Int32
    var name: String
    var assignee: User?
    var status: IssueStatus
    var type: IssueType
    var priority: IssuePriority
    var projectID: Int32
    var sprintID: Int32?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case assignee
        case type = "issueTypeID"
        case priority = "issuePriorityID"
        case status = "issueStatusID"
        case projectID
        case sprintID
    }
}

extension IssueGeneralDTO {
    init() { self.init(id: .default, name: .default, status: .toDo, type: .toDo, priority: .medium, projectID: .default) }
}


