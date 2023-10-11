//
//  SignUpFinalisationView.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import SwiftUI

struct SignUpFinalisationView: View {
    @ObservedObject var vm: SignUpViewModel
    @FocusState private var focusedField: FocusedField?
    
    private enum FocusedField: Hashable {
        case password
        case confirmPassword
    }
    
    var body: some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Create", highlighted: "password")
            PasswordField(title: "Password", text: $vm.password, focusedField: $focusedField, equals: .password)
                .onSubmit { focusedField = .confirmPassword }
            
            Divider()
            
            PasswordField(title: "Confirm password", text: $vm.confirmPassword, focusedField: $focusedField, equals: .confirmPassword)
                .onSubmit { if vm.doesPasswordsMatch { vm.signUp() } }
            
            Button("Sign up") {
                vm.signUp()
            }
            .buttonStyle(.secondary)
            .disabled(!vm.doesPasswordsMatch)
            
            Spacer()
        }
        .padding()
        .onAppear { focusedField = .password }
    }
    
}

struct SignUpFinalisationView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFinalisationView(vm: SignUpViewModel())
    }
}
