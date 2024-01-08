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
    let userInteractor: any UserInteractor
    let authenticationInteractor: any AuthenticationInteractor
    
    @Published var credentials: SignInRequest
    @Published var focus: Field? = nil
    
    enum Field: Hashable {
        case email
        case password
    }
    
    func onSubmitOf(field: Field) {
        switch field {
        case .email:
            focus = .password
        case .password:
            focus = .none
            onSignInButtonTapped()
        }
    }
    
    //TODO: Add real validation here
    var isValid: Bool {
        guard credentials.email.isEmpty || credentials.password.isEmpty else {
            return true
        }
        
        return false
    }
    
    func onSignInButtonTapped() {
        Task {
            try await authenticationInteractor.signIn(credentials)
            try await userInteractor.signedUserInfo()
            
            credentials = .init()
        }
    }
    
    init(container: Container = Container.shared, crendentials: SignInRequest = SignInRequest(), focus: Field? = .email) {
        self.userInteractor = container.userInteractor.resolve()
        self.authenticationInteractor = container.authenticationInteractor.resolve()
        
        self.credentials = crendentials
        self.focus = focus
    }
}
