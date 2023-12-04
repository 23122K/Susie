import SwiftUI

struct UnauthenticatedRootView: View {
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    UserGreetingMessange()
                    
                    NavigationLink("\(.localized.signIn)") {
                        SignInView().custom(title: .localized.cancel)
                    }
                    .buttonStyle(.primary)
                    
                    CustomDivider()
                        .padding(.vertical,1)
                    
                    NavigationLink("\(.localized.letsGetStarted)") {
                        SignUpView().custom(title: .localized.cancel)
                    }.buttonStyle(.primary)
                    
                    Text(.localized.fullTermsOfServiceAndPrivacyPolies)
                    .font(.caption)
                    .padding(.horizontal, 33)
                }
            }
        }
    }
}

#Preview {
    UnauthenticatedRootView()
}
