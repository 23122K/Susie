//
//  Project.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

import Foundation

protocol ProjectEntity {
    var id: Int32 { get set }
}

//TODO: Change goal: String? to goal: String after its fixed

struct Project: ProjectEntity, Identifiable, Codable {
    var id: Int32
    let name: String
    let description: String
    let goal: String?
    let members: Array<User>
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case id = "projectID"
        case name
        case description
        case members
        case owner
        case goal = "projectGoal"
    }
}

extension Project {
    func toDTO() -> ProjectDTO {
        ProjectDTO(id: self.id, name: self.name, description: self.description, goal: self.goal)
    }
}

struct ProjectDTO: ProjectEntity, Identifiable, Codable, Hashable {
    var id: Int32
    let name: String
    let description: String
    let goal: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "projectID"
        case name
        case description
        case goal = "projectGoal"
    }
    
    init(id: Int32 = -1, name: String, description: String, goal: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.goal = goal
    }
}
