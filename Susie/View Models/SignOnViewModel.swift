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
    
    //Scrum Master additional input
    @Published var teamName: String = ""
    @Published var teamDescription: String = ""
    
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
    func register() {
        switch(self.registerAsAScrumMaster){
        case true: print("User would be registered as a ScrumMaster, but curerentyl im missing that endpoint")
        case false:
            let request = RegisterRequest(firstname: firstName, lastname: lastName, email: emial, password: password)
            model.register(request)
        }
    }

    
    
}
