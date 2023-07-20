import SwiftUI

struct SignInView: View {
    @StateObject private var vm = SignInViewModel()
    
    var body : some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Log in to", highlitedWord: "Susie")
            
            FormRowView(title: "Emial Address", text: $vm.emialAddress, content: {
                Image(systemName: "envelope")
            })
            
            PasswordField(title: "Password", text: $vm.password)
            Text(vm.error.occured ? vm.error.description : "")
            SecondaryButton(content: "Sign in", state: vm.isValid)
                .disabled(!vm.isValid)
                .onTapGesture {
                    if(vm.isValid){
                        vm.authenticate()
                    }
                }
            Spacer()
        }.padding()
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
