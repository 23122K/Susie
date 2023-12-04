import SwiftUI

struct PasswordField<T: Hashable>: View{
    @Binding private var text: String
    @State private var isHidden = true
    
    private var focusedField: FocusState<T>.Binding
    private var field: T
    
    private let title: LocalizedStringResource
    
    var body: some View {
        HStack{
            ZStack{
                Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.susieBluePriamry)
                    .padding(.top, 2)
            }
            .frame(width: 30)
            ZStack(alignment: .trailing){
                switch(isHidden){
                case true:
                    SecureField("\(title)", text: $text)
                        .focused(focusedField, equals: field)
                        .animation(.easeInOut(duration: 0.2), value: isHidden)
                case false:
                    TextField("\(title)", text: $text)
                        .keyboardType(.default)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .animation(.easeInOut(duration: 0.2), value: isHidden)
                }
                
                Button {
                    isHidden.toggle()
                } label: {
                    Image(systemName: isHidden ? "eye.slash" : "eye")
                        .foregroundColor(.blue.opacity(0.7))
                        .animation(.easeInOut(duration: 0.2), value: isHidden)
                }
            }
        }.frame(height: 50)
    }
    
    init(title: LocalizedStringResource, text: Binding<String>, focusedField: FocusState<T>.Binding, equals field: T) {
        _text = text
        self.focusedField = focusedField
        self.field = field
        self.title = title
    }
}
