import SwiftUI

struct PasswordField: View{
    let title: String
    @Binding var text: String
    @State private var isHidden = true
    
    var body: some View {
        HStack{
            ZStack{
                Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.blue.opacity(0.7))
                    .padding(.top, 2)
            }
            .frame(width: 30)
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
        }.frame(height: 50)
    }
}

struct PasswordField_Previews: PreviewProvider {
    static var previews: some View{
        PasswordField(title: "Password", text: .constant(""))
    }
}
