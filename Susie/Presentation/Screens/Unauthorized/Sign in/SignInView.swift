import SwiftUI

struct SignInView: View {
    @StateObject private var vm = SignInViewModel()
    @FocusState private var focus: SignInViewModel.Field?
    
    private let envelopeImage = Image(systemName: "envelope")
    
    var body : some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Log in to", highlighted: "Susie")
            
            CustomTextField(title: "Email address", text: $vm.credentials.email , keyboard: .emailAddress, focusedField: $focus, equals: .email) { envelopeImage }
                .onSubmit { focus = .password }
            
            Divider()
            
            PasswordField(title: "Password", text: $vm.credentials.password, focusedField: $focus, equals: .password)
                .onSubmit { if vm.isValid { vm.signIn() } }
            
            Button("Sign in") {
                vm.signIn()
            }
            .buttonStyle(.secondary)
            .disabled(!vm.isValid)

            Spacer()
        }
        .padding()
        .onAppear { focus = .email }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
