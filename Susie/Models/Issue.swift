//
//  Issue.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

struct Issue: Identifiable, Codable {
    let id: Int32
    let name: String
    let description: String
    let estimation: Int32
    let reporter: User
    let asignee: User?
    let priority: IssuePriority
    let status: IssueStatus
    let type: IssueType
    let projectID: Int32
    let sprintID: Int32?
    let comments: Array<Comment>
    
    enum CodingKeys: String, CodingKey {
        case id = "issueID"
        case name
        case description
        case estimation
        case reporter
        case asignee
        case type = "issueTypeID"
        case priority = "issuePriorityID"
        case status = "issueStatusID"
        case projectID
        case sprintID
        case comments
    }
}

extension Issue {
    func toGeneralDTO() -> IssueGeneralDTO {
        IssueGeneralDTO(id: self.id, name: self.name, asignee: self.asignee, status: self.status, type: self.type, priority: self.priority, projectID: self.projectID, sprintID: self.sprintID)
    }
}

extension Array where Element == IssueGeneralDTO {
    func with(status: IssueStatus) -> Array<IssueGeneralDTO> {
        self.filter { issue in
            issue.status == status
        }
    }
}

struct IssueDTO: Identifiable, Codable {
    let id: Int32
    let name: String
    let description: String
    let estimation: Int32
    let projectID: Int32
    let type: IssueType
    let priority: IssuePriority
    
    enum CodingKeys: String, CodingKey {
        case id = "issueID"
        case name
        case description
        case estimation
        case projectID
        case type = "issueTypeID"
        case priority = "issuePriorityID"
    }
    
    init(name: String, description: String, estimation: Int32, project: Project, type: IssueType, priority: IssuePriority) {
        self.id = -1
        self.name = name
        self.description = description
        self.estimation = estimation
        self.projectID = project.id
        self.type = type
        self.priority = priority
    }
}

struct IssueGeneralDTO: Identifiable, Codable {
    let id: Int32
    let name: String
    let asignee: User?
    let status: IssueStatus
    let type: IssueType
    let priority: IssuePriority
    let projectID: Int32
    let sprintID: Int32?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case asignee
        case type = "issueTypeID"
        case priority = "issuePriorityID"
        case status = "issueStatusID"
        case projectID
        case sprintID
    }
}
