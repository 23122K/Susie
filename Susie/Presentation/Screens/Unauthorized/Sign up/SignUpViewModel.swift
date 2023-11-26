//
//  SignUpViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import SwiftUI
import Factory

@MainActor
class SignUpViewModel: ObservableObject {
    let userInteractor: RealUserInteractor
    let authInteractor: RealAuthenticationInteractor
    
    @Published var credentials: SignUpRequest
    @Published var confirmPassword: String
    
    internal enum Field {
        case firstName
        case lastName
        case email
        case password
        case confirmPassword
    }
    
    //TODO: Add validation
    
    func signUp() {
        Task { 
            try await authInteractor.signUp(credentials)
            try await userInteractor.signedUserInfo()
            
            credentials = .init()
            confirmPassword = .init()
        }
    }
    
    init(container: Container = Container.shared, credentials: SignUpRequest = SignUpRequest(), confirmPassword: String = String()) {
        self.userInteractor = container.userInteractor.resolve()
        self.authInteractor = container.authenticationInteractor.resolve()
        self.credentials = credentials
        self.confirmPassword = confirmPassword
    }
}
