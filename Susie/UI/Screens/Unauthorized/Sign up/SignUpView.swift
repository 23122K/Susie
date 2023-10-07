import SwiftUI

struct SignUpView: View {
    @StateObject private var vm = SignUpViewModel()

    var body: some View {
        VStack(alignment: .leading){
            FormTitleView(title: "Create your", highlighted: "accout")
            
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
        
        NavigationLink("Next") {
            SignUpFinalisationView(vm: vm).custom(title: "Back")
        }
        .buttonStyle(.secondary)
        .disabled(vm.areCrendentailsValid)
        
        Spacer()
        
        HStack(alignment: .lastTextBaseline) {
            Checkbox(isSelected: $vm.isScrumMaster)
            Text("Register as a Scrum Master")
                .font(.callout)
            Spacer()
        }
        .padding()
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

