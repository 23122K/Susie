//
//  SignInViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/05/2023.
//

import SwiftUI
import Factory

@MainActor
class SignInViewModel: ObservableObject {
    @Injected (\.authenticationInteractor) var authenticationInteractor
    @Injected (\.store) var store
    
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
        defer { clean() }
        let credentials = SignInRequest(email: email, password: password)
        Task {
            try await authenticationInteractor.signIn(credentials)
            store.dispatch(.authenticate)
        }
    }
    
    func clean() {
        email = .init()
        password = .init()
    }
}
