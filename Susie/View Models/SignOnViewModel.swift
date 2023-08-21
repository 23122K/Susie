//
//  SignOnViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import SwiftUI

class SignOnViewModel: ObservableObject {
    @Injected(\.model) var model
    
    //MARK: Registration from inputs
    //Devs & Poroduct Owners
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var emial: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var registerAsAScrumMaster = false
    
    //MARK: Temp validation code
    var areCrendentailsValid: Bool {
        if(self.firstName == "" || self.lastName == "" || self.emial == "") {
            return true
        }
        return false
    }
    
    var doesPasswordsMatch: Bool {
        if(self.password == "" || self.confirmPassword == ""){
            return false
        }
        
        if(self.password == self.confirmPassword) {
            return true
        }
        
        return false
    }
    
    //MARK: Account creation request
    func signUp() {
        switch(self.registerAsAScrumMaster){
        case true:
            let credentials = SignUpRequest(firstName: firstName, lastName: lastName, email: emial, password: password, isScrumMaster: true)
            model.signUp(with: credentials)
        case false:
            let credentials = SignUpRequest(firstName: firstName, lastName: lastName, email: emial, password: password)
            model.signUp(with: credentials)
        }
    }

    
    
}
