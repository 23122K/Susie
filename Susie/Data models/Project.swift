//
//  Project.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

import Foundation

struct Project: Identifiable, Response {
    let id: Int32
    let name: String
    let description: String
    let users: Array<User>
    let owner: User
    let sprints: Array<Sprint>?
    
    enum CodingKeys: String, CodingKey {
        case id = "projectID"
        case name
        case description
        case users = "userIDs"
        case owner = "projectOwner"
        case sprints
    }
    
}

struct ProjectDTO: Response, Request {
    let projectID: Int32
    let name: String
    let description: String
    
    init(projectID: Int32 = 0, name: String, description: String) {
        self.projectID = projectID
        self.name = name
        self.description = description
    }
}
