import SwiftUI

struct WelcomePageView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    UserGreetingMessange()
                    NavigationLink(destination: SignInView().customNavigationView(title: "Cancel")
                        .navigationViewStyle(.stack), label: {
                            PrimaryButtonView(content: "Sign in")
                        })
                    
                    CustomDivider()
                        .padding(.vertical,1)
                    
                    NavigationLink(destination: SignUpView().customNavigationView(title: "Cancel")
                        .navigationViewStyle(.stack), label: {
                            PrimaryButtonView(content: "Let's get started")
                        })
                    
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

