import SwiftUI

struct SignUpView: View {
    @StateObject private var vm = SignUpViewModel()
    @FocusState private var focus: SignUpViewModel.Field?
    
    private let personImage = Image(systemName: "person")
    private let envelopeImage = Image(systemName: "envelope")
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                Text(.localized.createYourAccount)
                .font(.title)
                .bold()
                
                CustomTextField(title: .localized.fistName, text: $vm.credentials.firstName, keyboard: .default, focus: $focus, equals: .firstName) { personImage }
                    .onSubmit { vm.onSubmitOf(field: .firstName) }
                
                Divider()

                CustomTextField(title: .localized.lastName, text: $vm.credentials.lastName, keyboard: .default, focus: $focus, equals: .lastName) { personImage }
                    .onSubmit { vm.onSubmitOf(field: .lastName) }
                
                Divider()
                
                CustomTextField(title: .localized.email, text: $vm.credentials.email, keyboard: .emailAddress, focus: $focus, equals: .email) { envelopeImage }
                    .onSubmit { vm.onSubmitOf(field: .email) }
                
            }
            .padding()
            
            NavigationLink("\(.localized.next)") {
                SignUpFinalisationView(vm: vm)
                    .custom(title: .localized.next)
            }
            .buttonStyle(.secondary)
    
            Spacer()
            
            Checkbox(title: .localized.registerAsAScrumMaster, isSelected: $vm.credentials.isScrumMaster)
                .padding()
        }
        .bind($vm.focus, to: $focus)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
