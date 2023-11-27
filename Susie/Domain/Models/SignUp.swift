//
//  SignUp.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

struct SignUpRequest: Codable {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var isScrumMaster: Bool
}

extension SignUpRequest {
    init() { self.init(email: .default, password: .default, firstName: .default, lastName: .default, isScrumMaster: .deafult) }
}

struct SignUpResponse: Codable {
    let result: String
    let success: Bool
}
