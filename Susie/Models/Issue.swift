//
//  Issue.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

protocol IssueEntity {
    var id: Int32 { get set }
    
}

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
    }
}

extension Issue {
    func toGeneralDTO() -> IssueGeneralDTO {
        IssueGeneralDTO(id: self.id, name: self.name, asignee: self.asignee, status: self.status)
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
    
    init(id: Int32 = -1, name: String, description: String, estimation: Int32, project: Project, type: IssueType, priority: IssuePriority) {
        self.id = id
        self.name = name
        self.description = description
        self.estimation = estimation
        self.projectID = project.id
        self.type = type
        self.priority = priority
    }
}


//TODO: Add project id to issueGeneralDTO
struct IssueGeneralDTO: Identifiable, Codable {
    
    let id: Int32
    let name: String
    let asignee: User?
    let status: IssueStatus
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case asignee
        case status = "issueStatusID"
    }
}

extension IssueGeneralDTO {
    var type: IssueType { return IssueType.bug }
    var priority: IssuePriority { return IssuePriority.high }
    
}

enum IssueStatus: Int32, RawRepresentable, CaseIterable, Codable {
    case toDo = 1
    case inProgress = 2
    case inReview = 3
    case inTests = 4
    case done = 5
    
    var description: String {
        switch self {
        case .toDo:
            return "To do"
        case .inProgress:
            return "In progress"
        case .inReview:
            return "Code review"
        case .inTests:
            return "In tests"
        case .done:
            return "Done"
        }
    }
}

enum IssueType: Int32, RawRepresentable, CaseIterable, Codable {
    case userStory = 1
    case bug = 2
    case toDo = 3
    case aoa = 4
    
    var description: String {
        switch self {
        case .bug: 
            return "Bug"
        case .userStory:
            return "User story"
        case .toDo:
            return "To Do"
        case .aoa:
            return "Agile assignment"
        }
    }
}

enum IssuePriority: Int32, RawRepresentable, CaseIterable, Codable {
    case critical = 1
    case high = 2
    case medium = 3
    case low = 4
    case trivial = 5
    
    var description: String {
        switch self {
        case .critical:
            return "Critical"
        case .high:
            return "High"
        case .medium:
            return "Medium"
        case .low:
            return "Low"
        case .trivial:
            return "Trivial"
        }
    }
}
