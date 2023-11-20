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
    private var client: Client
    
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
            do { try await client.signIn(with: credentials) } catch {
                print("Invalid credentials")
            }
        }
    }
    
    func clean() {
        email = .init()
        password = .init()
    }
    
    init(container: Container = Container.shared) {
        self.client = container.client()
    }
}
