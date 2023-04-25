import SwiftUI

struct PasswordField: View{
    let title: String
    @Binding var text: String
    @State private var isHidden = true
    
    var body: some View {
        ZStack(alignment: .trailing){
            switch(isHidden){
            case true:
                SecureField(title, text: $text)
            case false:
                TextField(title, text: $text)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            }
            
            Button {
                isHidden.toggle()
            } label: {
                Image(systemName: isHidden ? "eye.slash" : "eye")
                    .foregroundColor(.blue.opacity(0.7))
            }
        }
    }
}
