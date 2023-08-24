//
//  Project.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

import Foundation

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

struct ProjectDTO: Codable {
    let projectID: Int32
    let name: String
    let description: String
    
    init(projectID: Int32 = 0, name: String, description: String) {
        self.projectID = projectID
        self.name = name
        self.description = description
    }
}
