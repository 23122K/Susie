//
//  SignUpFinalisationView.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import SwiftUI

struct SignUpFinalisationView: View {
    @ObservedObject var vm: SignOnViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Create", highlitedWord: "password")
            PasswordField(title: "Password", text: $vm.password)
            Divider()
            PasswordField(title: "Confirm password", text: $vm.confirmPassword)
        }
        .padding()
        
        SecondaryButton(content: "Sign up", state: vm.doesPasswordsMatch)
            .disabled(!vm.doesPasswordsMatch)
            .onTapGesture {
                vm.signUp()
            }
        Spacer()
    }
}

struct SignUpFinalisationView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpFinalisationView(vm: SignOnViewModel())
    }
}
