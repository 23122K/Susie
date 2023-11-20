//
//  IssueGeneralDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

class IssueGeneralDTO: Identifiable, Codable {
    var id: Int32
    let name: String
    let assignee: User?
    let status: IssueStatus
    let type: IssueType
    let priority: IssuePriority
    let projectID: Int32
    let sprintID: Int32?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case assignee
        case type = "issueTypeID"
        case priority = "issuePriorityID"
        case status = "issueStatusID"
        case projectID
        case sprintID
    }
    
    required init(id: Int32, name: String, assignee: User?, status: IssueStatus, type: IssueType, priority: IssuePriority, projectID: Int32, sprintID: Int32?) {
        self.id = id
        self.name = name
        self.assignee = assignee
        self.status = status
        self.type = type
        self.priority = priority
        self.projectID = projectID
        self.sprintID = sprintID
    }
}
