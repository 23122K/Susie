//
//  IssueDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

struct IssueDTO: Identifiable, Codable {
    let id: Int32
    var name: String
    var description: String
    var estimation: Int32
    var projectID: Int32
    var type: IssueType
    var priority: IssuePriority
    
    private enum CodingKeys: String, CodingKey {
        case id = "issueID"
        case name
        case description
        case estimation
        case projectID
        case type = "issueTypeID"
        case priority = "issuePriorityID"
    }
}

extension IssueDTO {
    init(project: Project) { self.init(id: .default, name: .default, description: .default, estimation: .default, projectID: project.id, type: .toDo, priority: .medium) }
}
