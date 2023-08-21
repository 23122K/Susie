//
//  SignInViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/05/2023.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @Injected(\.model) var model
    @Published var email = ""
    @Published var password = ""
    
    var isValid: Bool {
        if (email != "" && password != "") {
            return true
        }
        return false
    }
    
    func signIn() {
        let credentials = SignInRequest(email: email, password: password)
        model.signIn(with: credentials)
    }
    
    init() { }
}
