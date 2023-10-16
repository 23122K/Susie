//
//  Issue.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

class Issue: Identifiable, Codable {
    var id: Int32
    var name: String
    var description: String
    var estimation: Int32
    var reporter: User
    var asignee: User?
    var priority: IssuePriority
    var status: IssueStatus
    var type: IssueType
    var projectID: Int32
    var sprintID: Int32?
    var comments: Array<Comment>
    
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

class IssueDTO: Identifiable, Codable {
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
    
    init(name: String, description: String, estimation: Int32, project: ProjectDTO, type: IssueType, priority: IssuePriority) {
        self.id = -1
        self.name = name
        self.description = description
        self.estimation = estimation
        self.projectID = project.id
        self.type = type
        self.priority = priority
    }
}

class IssueGeneralDTO: Identifiable, Codable {
    var id: Int32
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
    
    required init(id: Int32, name: String, asignee: User?, status: IssueStatus, type: IssueType, priority: IssuePriority, projectID: Int32, sprintID: Int32?) {
        self.id = id
        self.name = name
        self.asignee = asignee
        self.status = status
        self.type = type
        self.priority = priority
        self.projectID = projectID
        self.sprintID = sprintID
    }
}
