//
//  ProjectDTO.swift
//  Susie
//
//  Created by Patryk Maciąg on 17/08/2023.
//

import Foundation


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
