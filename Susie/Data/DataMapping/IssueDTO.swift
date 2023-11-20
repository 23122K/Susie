//
//  IssueDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

class IssueDTO: Identifiable, Codable {
    let id: Int32
    var name: String
    var description: String
    var estimation: Int32
    var projectID: Int32
    var type: IssueType
    var priority: IssuePriority
    
    enum CodingKeys: String, CodingKey {
        case id = "issueID"
        case name
        case description
        case estimation
        case projectID
        case type = "issueTypeID"
        case priority = "issuePriorityID"
    }
    
    init(id: Int32, name: String, description: String, estimation: Int32, projectID: Int32, type: IssueType, priority: IssuePriority) {
        self.id = id
        self.name = name
        self.description = description
        self.estimation = estimation
        self.projectID = projectID
        self.type = type
        self.priority = priority
    }
    
    convenience init(project: ProjectDTO) {
        self.init(id: -1, name: "", description: "", estimation: 0, projectID: project.id, type: .toDo, priority: .medium)
    }
}
