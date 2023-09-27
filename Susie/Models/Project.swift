//
//  Project.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

import Foundation

//MARK: DAO

struct Project: Identifiable, Codable {
    let id: Int32
    let name: String
    let description: String
    let members: Array<User>
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case id = "projectID"
        case name
        case description
        case members
        case owner
    }
}

extension Project {
    func toDTO() -> ProjectDTO {
        ProjectDTO(id: self.id, name: self.name, description: self.description)
    }
}

//MARK: DTO

struct ProjectDTO: Identifiable, Codable, Hashable {
    let id: Int32
    let name: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "projectID"
        case name
        case description
    }
    
    init(id: Int32 = 0, name: String, description: String) { //In some cases project id is not necessary
        self.id = id
        self.name = name
        self.description = description
    }
}
