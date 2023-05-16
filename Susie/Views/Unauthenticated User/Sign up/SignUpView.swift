import SwiftUI

struct SignUpView: View {
    @StateObject private var vm = SignOnViewModel()

    var body: some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Create your", highlitedWord: "accout")
            
            FormRowView(title: "First name", text: $vm.firstName, content: {
                Image(systemName: "person")
            })
            FormRowView(title: "Last name", text: $vm.lastName, content: {
                Image(systemName: "person")
            })
            FormRowView(title: "Email address", text: $vm.emial, divider: false, content: {
                Image(systemName: "envelope")
            })
            
        }
        .padding()
        
        switch(vm.registerAsAScrumMaster){
        case true:
            NavigationLink(destination: CreateTeamView(vm: vm)
                .customNavigationView(title: "Back"),
            label: {
                SecondaryButton(content: "Next", state: !vm.areCrendentailsValid)
            })
            .disabled(vm.areCrendentailsValid)
        case false:
            NavigationLink(destination: SignUpFinalisationView(vm: vm)
                .customNavigationView(title: "Back"), label: {
                SecondaryButton(content: "Next", state: !vm.areCrendentailsValid)
            })
            .disabled(vm.areCrendentailsValid)
        }
        
        Spacer()
        Checkbox(title: "Register as a Scrum Master", isChecked: $vm.registerAsAScrumMaster)
            .padding()
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

