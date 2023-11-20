//
//  ProjectDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

class ProjectDTO: ProjectEntity, Identifiable, Codable {
    var id: Int32
    var name: String
    var description: String
    var goal: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "projectID"
        case name
        case description
        case goal = "projectGoal"
    }
    
    init(id: Int32 = -1, name: String, description: String, goal: String) {
        self.id = id
        self.name = name
        self.description = description
        self.goal = goal
    }
}
