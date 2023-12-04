//
//  Project.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

import Foundation

struct Project: Identifiable, Codable, Equatable {
    var id: Int32
    var name: String
    var description: String
    var goal: String
    var members: Array<User>
    var owner: User
    
    private enum CodingKeys: String, CodingKey {
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
    
    static var mock: Project {
        Project(id: .default, name: "Mock name", description: "Mock description", goal: "Mock goal", members: [.mock], owner: .mock)
    }
}
