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
    
    init(firstName: String, lastName: String, email: String, password: String, isScrumMaster: Bool) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.isScrumMaster = isScrumMaster
    }
}

extension SignUpRequest {
    struct Confirm {
        var password: String
    }
}

extension SignUpRequest {
    init() { self.init(firstName: String(), lastName: String(), email: String(), password: String(), isScrumMaster: Bool()) }
}

struct SignUpResponse: Codable {
    let result: String
    let success: Bool
}
