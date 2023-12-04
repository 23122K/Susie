import SwiftUI

struct SignInView: View {
    @StateObject private var vm = SignInViewModel()
    @FocusState private var focus: SignInViewModel.Field?
    
    private let envelopeImage = Image(systemName: "envelope")
    
    var body : some View {
        VStack(alignment: .leading){
//            Text(localized.logInToSusie.fill(words: [.localized.susie], with: .susieBluePriamry))")
            Text(.localized.logInToSusie)
            .font(.title)
            .bold()
            
            CustomTextField(title: .localized.email, text: $vm.credentials.email , keyboard: .emailAddress, focus: $focus, equals: .email) { envelopeImage }
                .onSubmit { vm.onSubmitOf(field: .email) }
            
            Divider()
            
            PasswordField(title: .localized.password, text: $vm.credentials.password, focusedField: $focus, equals: .password)
                .onSubmit { vm.onSubmitOf(field: .password) }
            
            Button("\(.localized.signIn)") { vm.onSignInButtonTapped() }
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
