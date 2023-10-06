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
        self.uuid = String()
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension User {
    var initials: String {
        let index = firstName.index(firstName.startIndex, offsetBy: 1)
        let result = firstName.prefix(upTo: index) + lastName.prefix(upTo: index)
        return result.uppercased()
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
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



enum UserScope: String, CaseIterable {
    case sm = "sm"
    case dev = "client_user"
    case none
}
