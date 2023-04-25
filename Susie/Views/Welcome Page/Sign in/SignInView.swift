//
//  LogInView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var logic: Logic
    @State var emial = ""
    @State var password = ""
    
    var isNotEmpty: Bool {
        if(emial == "" || password == "" ) { return false }

        return true
    }
    
    var body : some View{
        VStack(alignment: .leading){
            Group{
                Text("Log in to ") +
                Text("Susie")
                    .foregroundColor(.blue.opacity(0.7))
            }
            .multilineTextAlignment(.trailing)
            .font(.title)
            .bold()
            .padding(.horizontal, 20)
            
            VStack{
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: "envelope")
                            .foregroundColor(.blue.opacity(0.7))
                        TextField("Email Address", text: self.$emial)
                            .autocorrectionDisabled(true)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    .frame(height: 50)
                    
                    Divider()
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "lock")
                            .resizable()
                            .frame(width: 15, height: 18)
                            .foregroundColor(.blue.opacity(0.7))
                            .padding(.top, 2)
                        
                        PasswordField(title: "Password", text: self.$password)
                        
                    }
                    .frame(height: 50)
                    
                }
                .padding(.vertical)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                
                
                Button(action: {
                    let credentials = AuthenticationRequest(email: self.emial, password: self.password)
                    logic.authenticate(with: credentials)
                }) {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                    
                }.background(
                    isNotEmpty ? (Color.blue.opacity(0.7)) : (Color.gray.opacity(0.7))
                )
                .cornerRadius(25)
                .offset(y: -40)
                .padding(.bottom, -40)
                .shadow(color: Color.gray.opacity(0.4), radius: 16)
                .disabled(!isNotEmpty)
               
                Spacer()
            }
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(Logic())
    }
}
