import SwiftUI

struct WelcomePageView: View {
    var body: some View {
        
        NavigationView {
            ScrollView{
                ZStack{
                    VStack{
                        ZStack(alignment: .top) {
                            Image("WelcomeImage")
                                .resizable()
                                .scaledToFit()
                                .scaleEffect(1.1)
                        }
                        
                        ZStack(alignment: .center){
                            VStack(alignment: .leading){
                                HStack{
                                    Text("Be")
                                    Text("agile.")
                                        .foregroundColor(.blue)
                                        .opacity(0.6)
                                    Text("Get more done.")
                                }
                                .font(.title)
                                .bold()
                                .padding(.bottom, 5)
                                
                                Group{
                                    Text("Get started today and see how")
                                    +
                                    Text(" Susie")
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                    +
                                    Text(" can help you and your team achieve goals with ease.")
                                }
                                .font(.title3)
                                
                            }
                        }
                        .padding(.horizontal)
                        .offset(y: -10)
                        
                        
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
                        
                        Group{
                            Text("By signing up, you agree to our")
                            +
                            Text(" Terms of Service")
                                .foregroundColor(.blue)
                            +
                            Text(",")
                            +
                            Text(" Privacy ")
                                .foregroundColor(.blue)
                            +
                            Text("and ")
                            +
                            Text("Cookie Use")
                                .foregroundColor(.blue)
                        }
                        .font(.caption)
                        .padding(.horizontal, 33)
                        
                    }
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

