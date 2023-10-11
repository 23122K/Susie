import SwiftUI

struct SignInView: View {
    @StateObject private var vm = SignInViewModel()
    @FocusState private var focusedField: Field?
    
    private let envelopeImage = Image(systemName: "envelope")
    
    private enum Field: Hashable {
        case email
        case password
    }
    
    var body : some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Log in to", highlighted: "Susie")
            
            CustomTextField(title: "Email address", text: $vm.email, keyboard: .emailAddress, focusedField: $focusedField, equals: .email) { envelopeImage }
                .onSubmit { focusedField = .password }
            
            Divider()
            
            PasswordField(title: "Password", text: $vm.password, focusedField: $focusedField, equals: .password)
                .onSubmit { if vm.isValid { vm.signIn() } }
            
            Button("Sign in") {
                vm.signIn()
            }
            .buttonStyle(.secondary)
            .disabled(!vm.isValid)

            Spacer()
        }
        .padding()
        .onAppear {
            focusedField = .email
        }
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
