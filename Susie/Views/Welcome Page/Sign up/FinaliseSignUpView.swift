//
//  CreatePasswordView.swift
//  Susie
//
//  Created by Patryk Maciąg on 07/04/2023.
//

import SwiftUI

struct FinaliseSignUpView: View {
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
            Text("Create password")
                .font(.title)
                .bold()
            
            HStack(spacing: 15){
                Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.blue.opacity(0.7))
                    .padding(.top, 2)
                
                PasswordField(title: "Password", text: self.$password)
                
            }
            .frame(height: 50)
            
            Divider()
            
            HStack(spacing: 15){
                
                Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.blue.opacity(0.7))
                    .padding(.top, 2)
                
                PasswordField(title: "Confirm password", text: self.$confirmPassword)
                
            }
            .frame(height: 50)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        
        Button(action: {
            let user = RegisterRequest(firstname: firstName , lastname: lastName, email: email, password: password)
            logic.register(user)
            
        }) {
            Text("Sign in")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 100)
            
        }.background(
            doesPasswordsMatch ? Color.blue.opacity(0.7) : Color.gray.opacity(0.7)
        )
        .cornerRadius(25)
        .offset(y: -40)
        .padding(.bottom, -40)
        .shadow(color: Color.gray.opacity(0.4), radius: 16)
        .disabled(!doesPasswordsMatch)
        
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
