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
    let userInteractor: RealUserInteractor
    let authenticationInteractor: RealAuthenticationInteractor
    
    @Published var credentials: SignInRequest
    
    internal enum Field: Hashable {
        case email
        case password
    }
    
    //TODO: Add real validation here
    var isValid: Bool {
        guard credentials.email.isEmpty || credentials.password.isEmpty else {
            return true
        }
        
        return false
    }
    
    func signIn() {
        Task {
            try await authenticationInteractor.signIn(credentials)
            try await userInteractor.signedUserInfo()
            
            credentials = .init()
        }
    }
    
    init(container: Container = Container.shared, crendentials: SignInRequest = SignInRequest()) {
        self.userInteractor = container.userInteractor.resolve()
        self.authenticationInteractor = container.authenticationInteractor.resolve()
        self.credentials = crendentials
    }
}
