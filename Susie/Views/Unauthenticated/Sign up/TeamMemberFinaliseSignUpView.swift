//
//  CreatePasswordView.swift
//  Susie
//
//  Created by Patryk Maciąg on 07/04/2023.
//

import SwiftUI

struct TeamMemberFinaliseSignUpView: View {
    @EnvironmentObject var logic: Logic
    
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    
    var doesPasswordsMatch: Bool {
        if(password == "" || confirmPassword == ""){
            return false
        }
        
        if(password == confirmPassword) {
            return true
        }
        
        return false
    }
    
    var body: some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Create", highlitedWord: "password")
            
            PasswordField(title: "Password", text: self.$password)
            Divider()
            PasswordField(title: "Confirm password", text: self.$confirmPassword)
        }
        .padding()
        
        SecondaryButton(content: "Sign in", state: doesPasswordsMatch)
            .disabled(!doesPasswordsMatch)
            .onTapGesture {
                if(doesPasswordsMatch){
                    let user = RegisterRequest(firstname: firstName , lastname: lastName, email: email, password: password)
                    logic.register(user)
                }
            }
        Spacer()
    }
}

/*
struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasswordView()
    }
}
*/
