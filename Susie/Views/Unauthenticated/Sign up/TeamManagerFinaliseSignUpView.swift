//
//  TeamManagerFinaliseSignUpView.swift
//  Susie
//
//  Created by Patryk Maciąg on 03/05/2023.
//

import SwiftUI

struct TeamManagerFinaliseSignUpView: View {
    @EnvironmentObject var logic: Logic
    
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    @Binding var teamName: String
    @Binding var teamDescription: String
    
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
                //Create user + team as the user is registering as a team manager
                print("Team manager")
            }
        Spacer()
    }
}

/*
struct TeamManagerFinaliseSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        TeamManagerFinaliseSignUpView()
    }
}
*/
