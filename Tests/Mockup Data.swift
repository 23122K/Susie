//
//  MockupData.swift
//  Tests
//
//  Created by Patryk Maciąg on 25/09/2023.
//

import Foundation
@testable import Susie

public struct Mockup {
    internal enum Project {
        static let id: Int32 = 0
        static let name: String = "example_name"
        static let description: String = "example_description"
        static let members: Array<User> = []
//        static let owner: User = User(email: Mockup.User.email, firstName: Mockup.User.firstName, lastName: Mockup.User.lastName)
        
        static let data: Data = """
        {
            "projectID": \(id),
            "name": "\(name)",
            "description": "\(description)",
            "members": [],
            "owner": {
                "uuid": "\(User.uuid)",
                "firstName": "\(User.firstName)",
                "lastName": "\(User.lastName)",
                "email": "\(User.email)"
            }
        }
        """.data(using: .utf8)!
        
    }
    
    internal enum ProjectDTO {
        static let name: String = "example_name"
        static let description: String = "example_description"
    }
    
    internal enum IssueDTO {
        static let id: Int32 = -1
        static let name = "example_name"
        static let description = "example_description"
        static let estimation: Int32 = 6
        static let projectID: Int32 = 1
        static let issueTypeID: Int32 = 2
        static let issuePriorityID: Int32 = 3

        static let data = """
        {
            "issueID": \(id),
            "name": "\(name)",
            "description": "\(description)",
            "estimation": \(estimation),
            "projectID": \(projectID),
            "issueTypeID": \(issueTypeID),
            "issuePriorityID": \(issuePriorityID)
        }
        """.data(using: .utf8)!
    }
    
    internal enum IssueGeneralDTO {
        static let id: Int32 = 1
        static let name: String = "example_name"
        static let issueStatusID: Int32 = 1
        
        static let data = """
        {
            "id": \(id),
            "name": "\(name)",
            "issueStatusID": \(issueStatusID)
        }
        """.data(using: .utf8)!
        
    }
    
    internal enum Auth {
        static let token: String = "example_token"
    }
    
    internal enum UserRole {
        static let id: String = "user_role_id"
        static let name: String =  "user_role_name"
    }
    
    internal enum User {
        static let uuid: String = "example_uuid"
        static let firstName: String = "John"
        static let lastName: String = "Doe"
        static let email: String = "John@example.com"
        static let password: String = "example_password"
        
        static let data: Data = """
        {
            "uuid": "\(uuid)",
            "firstName": "\(firstName)",
            "lastName": "\(lastName)",
            "email": "\(email)"
        }
        """.data(using: .utf8)!
    }
    
    internal enum SignUpRequest {
        static let email: String = "John@example.com"
        static let password: String = "example_password"
        static let firstName: String = "John"
        static let lastName: String = "Doe"
        static let isScrumMaster: Bool = true
    }
    
    internal enum SignInRequest {
        static let email: String = "John@example.com"
        static let password: String = "example_password"
    }
    
    internal enum SignInResponse {
        static let accessToken: String = "access_token"
        static let refreshToken: String = "refresh_token"
        static let expiresIn: Int32 = 3600
        static let refreshExpiresIn: Int32 = 86400
        
        static let data: Data = """
        {
            "access_token": "\(accessToken)",
            "refresh_token": "\(refreshToken)",
            "expires_in": \(expiresIn),
            "refresh_expires_in": \(refreshExpiresIn),
            "userRoles": [
                {
                    "id": "\(UserRole.id)",
                    "name": "\(UserRole.name)"
                }
            ]
        }
        """.data(using: .utf8)!
        
    }
}
