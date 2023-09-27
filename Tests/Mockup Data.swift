//
//  MockupData.swift
//  Tests
//
//  Created by Patryk Maciąg on 25/09/2023.
//

import Foundation
@testable import Susie

public struct Mockup {
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
            "email": "\(email)",
            "password": "\(password)"
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
