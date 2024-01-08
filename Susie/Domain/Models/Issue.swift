//
//  Issue.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

struct Issue: Identifiable, Codable {
    let id: Int32
    var name: String
    var description: String
    var estimation: Int32
    var reporter: User
    var assignee: User?
    var priority: IssuePriority
    var status: IssueStatus
    var type: IssueType
    var projectID: Int32
    var sprintID: Int32?
    var comments: Array<Comment>
    
    private enum CodingKeys: String, CodingKey {
        case id = "issueID"
        case name
        case description
        case estimation
        case reporter
        case assignee
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
        IssueGeneralDTO(id: self.id, name: self.name, assignee: self.assignee, status: self.status, type: self.type, priority: self.priority, projectID: self.projectID, sprintID: self.sprintID)
    }
    
    func toDTO() -> IssueDTO {
        IssueDTO(id: self.id, name: self.name, description: self.description, estimation: self.estimation, projectID: self.projectID, type: self.type, priority: self.priority)
    }
    
    static var mock: Issue {
        Issue(id: .default, name: "Mock issue name", description: "Mode description", estimation: .default, reporter: .mock, priority: .medium, status: .inProgress, type: .toDo, projectID: .default, comments: Array<Comment>())
    }
}
