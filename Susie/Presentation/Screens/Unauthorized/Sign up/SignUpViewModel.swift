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
    let userInteractor: any UserInteractor
    let authInteractor: any AuthenticationInteractor
    
    @Published var credentials: SignUpRequest
    @Published var confirmPassword: String
    @Published var focus: Field?
    
    enum Field {
        case firstName
        case lastName
        case email
        case password
        case confirmPassword
    }
    
    func onSubmitOf(field: Field) {
        switch field {
        case .firstName:
            focus = .lastName
        case .lastName:
            focus = .email
        case .email:
            focus = .password
        case .password:
            focus = .confirmPassword
        case .confirmPassword:
            focus = .none
        }
    }
    
    //TODO: Add validation
    
    func onSignUpButtonTapped() {
        Task {
            try await authInteractor.signUp(credentials)
            try await userInteractor.signedUserInfo()
            
            credentials = .init()
            confirmPassword = .init()
        }
    }
    
    init(container: Container = Container.shared, credentials: SignUpRequest = SignUpRequest(), confirmPassword: String = String(), focus: Field? = .firstName) {
        self.userInteractor = container.userInteractor.resolve()
        self.authInteractor = container.authenticationInteractor.resolve()
        
        self.credentials = credentials
        self.confirmPassword = confirmPassword
        self.focus = focus
    }
}
