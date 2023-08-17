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
    let backlog: Backlog
    let users: Array<String>
    let owner: String //Is it his ID?
    let sprints: Array<Sprint>?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case backlog
        case users = "userIDs"
        case owner = "projectOwner"
        case sprints
    }
}
