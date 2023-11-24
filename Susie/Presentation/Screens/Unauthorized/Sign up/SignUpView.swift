import SwiftUI

struct SignUpView: View {
    @StateObject private var vm = SignUpViewModel()
    @FocusState private var focus: SignUpViewModel.Field?
    
    private let personImage = Image(systemName: "person")
    private let envelopeImage = Image(systemName: "envelope")
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                FormTitleView(title: "Create your", highlighted: "accout")
                
                CustomTextField(title: "First name", text: $vm.credentials.firstName, keyboard: .default, focusedField: $focus, equals: .firstName) { personImage }
                    .onSubmit { focus = .lastName }
                
                Divider()

                CustomTextField(title: "Last name", text: $vm.credentials.lastName, keyboard: .default, focusedField: $focus, equals: .lastName) { personImage }
                    .onSubmit { focus = .email }
                
                Divider()
                
                CustomTextField(title: "Email address", text: $vm.credentials.email, keyboard: .emailAddress, focusedField: $focus, equals: .email) { envelopeImage }
//                    .onSubmit { if !vm.areCrendentailsValid { isPresented.toggle() } }
                
            }
            .padding()
            
            NavigationLink("Next", destination: {
                SignUpFinalisationView(vm: vm)
                    .custom(title: "Back")
            })
            .buttonStyle(.secondary)
    
            Spacer()
            
            Checkbox(title: "Register as a scrum master", isSelected: $vm.credentials.isScrumMaster)
                .padding()
        }
        .onAppear { focus = .firstName }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
