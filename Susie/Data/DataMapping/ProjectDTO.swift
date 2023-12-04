//
//  ProjectDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

struct ProjectDTO: Identifiable, Codable, Equatable {
    let id: Int32
    var name: String
    var description: String
    var goal: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "projectID"
        case name
        case description
        case goal = "projectGoal"
    }
}

extension ProjectDTO {
    init() { self.init(id: .default, name: .default, description: .default, goal: .default) }
}

extension ProjectDTO {
    static var mock: ProjectDTO {
        ProjectDTO(id: .default, name: "Mock name", description: "Mock description", goal: "Mock goal")
    }
}
