import SwiftUI

struct SignInView: View {
    @StateObject private var vm = SignInViewModel()
    
    var body : some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Log in to", highlighted: "Susie")
            
            FormRowView(title: "Emial Address", text: $vm.email, content: {
                Image(systemName: "envelope")
            })
            
            PasswordField(title: "Password", text: $vm.password)
            
            Button("Sign in") {
                vm.signIn()
            }
            .buttonStyle(.secondary)
            .disabled(!vm.isValid)

            Spacer()
        }.padding()
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
