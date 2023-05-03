import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var logic: Logic
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var emial: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    //Checkbox value which checks if a user want to be register as a Scrum Master
    @State private var isChecked: Bool = false
    
    var areEmpty: Bool {
        if(firstName == "" || lastName == "" || emial == "") {
            return true
        }
        
        return false
    }
    
    var body: some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Create your", highlitedWord: "accout")
            
            FormRowView(title: "First name", text: $firstName, content: {
                Image(systemName: "person")
            })
            FormRowView(title: "Last name", text: $lastName, content: {
                Image(systemName: "person")
            })
            FormRowView(title: "Email address", text: $emial, divider: false, content: {
                Image(systemName: "envelope")
            })
            
        }
        .padding()
        
        switch(isChecked){
        case true:
            NavigationLink(destination: CreateTeamView(password: $password, confirmPassword: $confirmPassword, firstName: $firstName, lastName: $lastName, email: $emial).customNavigationView(title: "Back"), label: {
                SecondaryButton(content: "Next", state: !areEmpty)
            })
            .disabled(areEmpty)
        case false:
            NavigationLink(destination: TeamMemberFinaliseSignUpView(password: $password, confirmPassword: $confirmPassword, firstName: $firstName, lastName: $lastName, email: $emial).customNavigationView(title: "Back"), label: {
                SecondaryButton(content: "Next", state: !areEmpty)
            })
            .disabled(areEmpty)
        }
        
        Spacer()
        Checkbox(title: "Register as a Scrum Master", isChecked: $isChecked)
            .padding()
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(Logic())
    }
}

