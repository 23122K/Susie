//
//  SignUpView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var logic: Logic
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var emial: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    
    var areEmpty: Bool {
        if(firstName == "" || lastName == "" || emial == "") {
            return true
        }
        
        return false
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Create your account")
                .font(.title)
                .bold()
            
            HStack(spacing: 15){
                Image(systemName: "person")
                    .foregroundColor(.blue.opacity(0.7))
                TextField("First name", text: self.$firstName)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
            }
            .frame(height: 50)
            .onAppear{
                
            }
            
            Divider()
            
            HStack(spacing: 15){
                Image(systemName: "person")
                    .foregroundColor(.blue.opacity(0.7))
                TextField("Last name", text: self.$lastName)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
            }
            .frame(height: 50)
            .onAppear{
                
            }
            
            Divider()

            HStack(spacing: 15){
                Image(systemName: "envelope")
                    .foregroundColor(.blue.opacity(0.7))
                TextField("Email address", text: self.$emial)
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            .frame(height: 50)
        }
        .padding(.horizontal, 20)
        
        NavigationLink(destination: FinaliseSignUpView(password: $password, confirmPassword: $confirmPassword, firstName: $firstName, lastName: $lastName, email: $emial).customNavigationView(title: "Back"), label: {
            SecondaryButton(content: "Next", state: !areEmpty)
        })
        .disabled(areEmpty)
        
        Spacer()
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(Logic())
    }
}

