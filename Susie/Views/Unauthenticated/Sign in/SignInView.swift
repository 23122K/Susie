import SwiftUI

struct SignInView: View {
    @EnvironmentObject var logic: Logic
    @State var emial = ""
    @State var password = ""
    
    //Will be removed in the future due to need of validation
    var isNotEmpty: Bool {
        if(emial == "" || password == "" ) { return false }

        return true
    }
    
    var body : some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Log in to", highlitedWord: "Suse")
            
            FormRowView(title: "Emial Address", text: $emial, content: {
                Image(systemName: "envelope")
            })
            
            PasswordField(title: "Password", text: self.$password)
            
            SecondaryButton(content: "Sign in", state: isNotEmpty)
                .disabled(!isNotEmpty)
                .onTapGesture {
                    if(isNotEmpty){
                        let credentials = AuthenticationRequest(email: self.emial, password: self.password)
                        logic.authenticate(with: credentials)
                    }
                }
            Spacer()
        }.padding()
    }
}


struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(Logic())
    }
}
