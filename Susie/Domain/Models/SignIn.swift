//
//  SignIn.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

struct SignInRequest: Codable {
    var email: String
    var password: String
}

extension SignInRequest {
    init() { self.init(email: .default, password: .default) }
}

struct SignInResponse: Codable {
    let accessToken: String
    let refreshToken: String
    
    let expiresIn: Int32
    let refreshExpiresIn: Int32
    
    let userRoles: Array<UserRole>
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
        case userRoles
    }
}
