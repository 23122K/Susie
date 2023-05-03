import SwiftUI

struct CreateTeamView: View {
    @State private var teamName: String = ""
    @State private var teamDescription: String = ""
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var firstName: String
    @Binding var lastName: String
    @Binding var email: String
    
    var body: some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Create your", highlitedWord: "team")

            FormRowView(title: "Team name", text: $teamName, content: {
                Image(systemName: "person.3")
            })
            
            FormRowView(title: "Team description", text: $teamDescription, divider: false, content: {
                Image(systemName: "text.word.spacing")
            })
            
            NavigationLink(destination: {
                TeamManagerFinaliseSignUpView(password: $password, confirmPassword: $confirmPassword, firstName: $firstName, lastName: $lastName, email: $email, teamName: $teamName, teamDescription: $teamDescription)
            }, label: {
                PrimaryButtonView(content: "Next")
            })
            Spacer() //Used to push everything to the top
        }
        .padding()
    }
}

/*
struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
       // CreateTeamView()
    }
}
*/
