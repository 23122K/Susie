import SwiftUI

struct SignUpView: View {
    @StateObject private var vm = SignUpViewModel()
    @FocusState private var focusedField: FocusedField?
    @State private var isPresented: Bool = false
    
    private let personImage = Image(systemName: "person")
    private let envelopeImage = Image(systemName: "envelope")
    
    private enum FocusedField: Hashable {
        case fistName
        case lastName
        case email
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                FormTitleView(title: "Create your", highlighted: "accout")
                
                CustomTextField(title: "First name", text: $vm.firstName, keyboard: .default, focusedField: $focusedField, equals: .fistName) { personImage }
                    .onSubmit { focusedField = .lastName }
                
                Divider()

                CustomTextField(title: "Last name", text: $vm.lastName, keyboard: .default, focusedField: $focusedField, equals: .lastName) { personImage }
                    .onSubmit { focusedField = .email }
                
                Divider()
                
                CustomTextField(title: "Email address", text: $vm.emial, keyboard: .emailAddress, focusedField: $focusedField, equals: .email) { envelopeImage }
                    .onSubmit { if !vm.areCrendentailsValid { isPresented.toggle() } }
                
            }
            .padding()
            
            Button("Next") { isPresented.toggle() }
                .buttonStyle(.secondary)
                .disabled(vm.areCrendentailsValid)

            Spacer()
            
            Checkbox(title: "Register as a scrum master", isSelected: $vm.isScrumMaster)
                .padding()
        }
        .navigationDestination(isPresented: $isPresented) {
            SignUpFinalisationView(vm: vm)
                .custom(title: "Back")
        }
        .onAppear {
            focusedField = .fistName
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

