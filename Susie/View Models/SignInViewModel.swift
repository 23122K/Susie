//
//  SignInViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/05/2023.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    //MARK: Input
    @Injected(\.model) var model
    @Published var emialAddress = ""
    @Published var password = ""
    
    //MARK: Output
    var isValid: Bool {
        if (emialAddress != "" && password != "") {
            return true
        }
        
        return false
    }
    
    func authenticate() {
        let request = AuthenticationRequest(email: self.emialAddress, password: self.password)
        model.authenticate(with: request)
    }

    
    
}
