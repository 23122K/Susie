//
//  User.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

struct User: Identifiable, Codable, Equatable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case email
        case firstName
        case lastName
    }
}

extension User {
    static var mock: User {
        User(id: .default, email: "Joe@example.com", firstName: "Joe", lastName: "Doe")
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

struct InviteRequest: Codable {
    var email: String
    var projectID: Int32
    
    init(email: String, projectID: Int32) {
        self.email = email
        self.projectID = projectID
    }
}

extension InviteRequest {
    init() { self.init(email: String(), projectID: Int32()) }
    init(project: any ProjectEntity) { self.init(email: String(), projectID: project.id)}
}

struct UserRemovalDTO: Codable {
    let userUUID: String
    let projectID: Int32
    
    init(user: User, project: ProjectDTO) {
        self.userUUID = user.id
        self.projectID = project.id
    }
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
