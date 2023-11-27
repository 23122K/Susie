//
//  ProjectDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

struct ProjectDTO: ProjectEntity, Identifiable, Codable, Equatable {
    //TODO: Change id property to let
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
}

extension ProjectDTO {
    init() { self.init(id: .default, name: .default, description: .default, goal: .default) }
}

extension ProjectDTO {
    static var mock: ProjectDTO {
        ProjectDTO(id: .default, name: "Mock name", description: "Mock description", goal: "Mock goal")
    }
}
