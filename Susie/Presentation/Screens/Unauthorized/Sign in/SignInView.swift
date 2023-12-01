import SwiftUI

struct SignInView: View {
    @StateObject private var vm = SignInViewModel()
    @FocusState private var focus: SignInViewModel.Field?
    
    private let envelopeImage = Image(systemName: "envelope")
    
    var body : some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Log in to", highlighted: "Susie")
            
            CustomTextField(title: "Email address", text: $vm.credentials.email , keyboard: .emailAddress, focusedField: $focus, equals: .email) { envelopeImage }
                .onSubmit { vm.onSubmitOf(field: .email) }
            
            Divider()
            
            PasswordField(title: "Password", text: $vm.credentials.password, focusedField: $focus, equals: .password)
                .onSubmit { vm.onSubmitOf(field: .password) }
            
            Button("Sign in") { vm.onSignInButtonTapped() }
            .buttonStyle(.secondary)
            .disabled(!vm.isValid)

            Spacer()
        }
        .padding()
        .bind($vm.focus, to: $focus)
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
