//
//  User.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

struct User: Codable {
    let uuid: String
    let email: String
    let firstName: String
    let lastName: String
    
    init(email: String, firstName: String, lastName: String) {
        self.uuid = ""
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}

struct UserAssociationDTO: Codable {
    let email: String
    let projectID: Int32
}

struct UserRole: Identifiable, Codable {
    let id: String
    let name: String
}
