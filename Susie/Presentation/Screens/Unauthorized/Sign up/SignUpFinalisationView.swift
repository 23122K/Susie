//
//  SignUpFinalisationView.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import SwiftUI

struct SignUpFinalisationView: View {
    @ObservedObject var vm: SignUpViewModel
    @FocusState private var focus: SignUpViewModel.Field?
    
    var body: some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Create", highlighted: "password")
            PasswordField(title: "Password", text: $vm.credentials.password, focusedField: $focus, equals: .password)
                .onSubmit { vm.onSubmitOf(field: .password) }
            
            Divider()
            PasswordField(title: "Confirm password", text: $vm.confirmPassword, focusedField: $focus, equals: .confirmPassword)
                .onSubmit { vm.onSubmitOf(field: .confirmPassword) }
            
            Button("Sign up") {
                vm.onSignUpButtonTapped()
            }
            .buttonStyle(.secondary)
            
            Spacer()
        }
        .padding()
        .bind($vm.focus, to: $focus)
    }
    
}

struct SignUpFinalisationView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFinalisationView(vm: SignUpViewModel())
    }
}
