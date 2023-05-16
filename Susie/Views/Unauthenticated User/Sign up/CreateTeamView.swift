import SwiftUI

struct CreateTeamView: View {
    @ObservedObject var vm: SignOnViewModel
    var body: some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Create your", highlitedWord: "team")

            FormRowView(title: "Team name", text: $vm.teamName, content: {
                Image(systemName: "person.3")
            })
            
            FormRowView(title: "Team description", text: $vm.teamDescription, divider: false, content: {
                Image(systemName: "text.word.spacing")
            })
            
            NavigationLink(destination: {
                SignUpFinalisationView(vm: vm)
            }, label: {
                PrimaryButtonView(content: "Next")
            })
            Spacer() //Used to push everything to the top
        }
        .padding()
    }
}


struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
       CreateTeamView(vm: SignOnViewModel())
    }
}

