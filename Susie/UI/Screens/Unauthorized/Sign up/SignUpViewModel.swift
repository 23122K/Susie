//
//  SignUpViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import SwiftUI
import Factory

class SignUpViewModel: ObservableObject {
    private var client: Client
    
    @Published var firstName = String()
    @Published var lastName = String()
    @Published var emial = String()
    @Published var password = String()
    @Published var confirmPassword = String()
    @Published var isScrumMaster = true
    
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
//        defer { clean() }
        
        Task {
            switch isScrumMaster {
            case true:
                let credentials = SignUpRequest(firstName: firstName, lastName: lastName, email: emial, password: password, isScrumMaster: true)
                try await client.signUp(with: credentials)
            case false:
                let credentials = SignUpRequest(firstName: firstName, lastName: lastName, email: emial, password: password, isScrumMaster: false)
                try await client.signUp(with: credentials)
            }
            
            try await client.signIn(with: SignInRequest(email: emial, password: password))
        }
    }
    
    func clean() {
        firstName = .init()
        lastName = .init()
        emial = .init()
        password = .init()
        confirmPassword = .init()
        isScrumMaster = false
    }
    
    init(container: Container = Container.shared) {
        self.client = container.client()
    }
}
