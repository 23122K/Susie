//
//  SignInViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/05/2023.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @Injected(\.client) var client
    
    @Published var email = String()
    @Published var password = String()
    
    //TODO: Add real validation here
    var isValid: Bool {
        guard email.isEmpty || password.isEmpty else {
            return true
        }
        
        return false
    }
    
    func signIn() {
        let credentials = SignInRequest(email: email, password: password)
        client.signIn(with: credentials)
        self.cleanForms()
    }
    
    func cleanForms() {
        email = .init()
        password = .init()
    }
    
}
