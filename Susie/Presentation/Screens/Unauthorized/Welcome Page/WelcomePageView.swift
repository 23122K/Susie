import SwiftUI

struct WelcomePageView: View {
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    UserGreetingMessange()
                                   
                    NavigationLink("Sign in") {
                        SignInView().custom(title: "Cancel")
                    }.buttonStyle(.primary)
                    
                    CustomDivider()
                        .padding(.vertical,1)
                    
                    NavigationLink("Let's get started") {
                        SignUpView().custom(title: "Cancel")
                    }.buttonStyle(.primary)
                    
                    TermsOfService()
                }
            }
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePageView()
    }
}

