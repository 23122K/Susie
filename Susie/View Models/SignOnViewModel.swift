//
//  SignOnViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import SwiftUI

class SignOnViewModel: ObservableObject {
    @Injected(\.client) var client
    
    @Published var firstName = String()
    @Published var lastName = String()
    @Published var emial = String()
    @Published var password = String()
    @Published var confirmPassword = String()
    @Published var isScrumMaster = false
    
    //TODO: Chage to real validation
    var areCrendentailsValid: Bool {
        if(self.firstName == "" || self.lastName == "" || self.emial == "") {
            return true
        }
        return false
    }
    
    var doesPasswordsMatch: Bool {
        guard password.isEmpty || confirmPassword.isEmpty else {
            return password.hashValue == confirmPassword.hashValue
        }
        
        return false
    }
    
    func signUp() {
        Task {
            switch isScrumMaster {
            case true:
                let credentials = SignUpRequest(firstName: firstName, lastName: lastName, email: emial, password: password, isScrumMaster: true)
                try await client.signUp(with: credentials)
            case false:
                let credentials = SignUpRequest(firstName: firstName, lastName: lastName, email: emial, password: password)
                try await client.signUp(with: credentials)
            }
            cleanForms()
        }
    }
    
    func cleanForms() {
        firstName = .init()
        lastName = .init()
        emial = .init()
        password = .init()
        confirmPassword = .init()
        isScrumMaster = false
    }
}
