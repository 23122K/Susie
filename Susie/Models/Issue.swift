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
    let projectID: Int32?
    let type: Int32
    let priority: Int32
    let status: Int32
    
    enum CodingKeys: String, CodingKey {
        case id = "issueID"
        case name
        case description
        case estimation
        case reporter
        case asignee
        case projectID
        case type = "issueTypeID"
        case priority = "issuePriorityID"
        case status = "issueStatusID"
    }
}

extension Array where Element == IssueGeneralDTO {
    func with(status: IssueStatus) -> Array<IssueGeneralDTO> {
        self.filter{ issue in
            issue.issueStatusID == status.id
        }
    }
}

struct IssueDTO: Identifiable, Codable {
    let id: Int32
    let name: String
    let description: String
    let estimation: Int32
    let projectID: Int32
    let issueTypeID: Int32
    let issuePriorityID: Int32
    
    enum CodingKeys: String, CodingKey {
        case id = "issueID"
        case name
        case description
        case estimation
        case projectID
        case issueTypeID
        case issuePriorityID
    }
    
    init(id: Int32 = -1, name: String, description: String, estimation: Int32, project: Project, issueType: IssueType, issuePriority: IssuePriority) {
        self.id = id
        self.name = name
        self.description = description
        self.estimation = estimation
        self.projectID = project.id
        self.issueTypeID = issueType.id
        self.issuePriorityID = issuePriority.id
    }
}

struct IssueGeneralDTO: Identifiable, Codable {
    let id: Int32
    let name: String
    let asignee: User?
    let issueStatusID: Int32
}

struct IssueType: Identifiable, Codable, Hashable {
    let id: Int32
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "type"
    }
}

struct IssueStatus: Identifiable, Codable, Hashable {
    let id: Int32
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "statusName"
    }
}

struct IssuePriority: Identifiable, Codable, Hashable {
    let id: Int32
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case description = "priority"
    }
}

