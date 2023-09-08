//
//  FromRowView.swift
//  Susie
//
//  Created by Patryk Maciąg on 03/05/2023.
//

import SwiftUI

struct FormRowView<Content: View>: View {
    @Binding var text: String
    let title: String
    let divider: Bool
    let content: Content
    
    init(title: String, text: Binding<String>, divider: Bool = true,  @ViewBuilder content: () -> Content) {
        self.title = title
        self.divider = divider
        self.content = content()
        _text = text
    }
    
    var body: some View {
        HStack(spacing: 15){
            ZStack{
                content
                    .foregroundColor(.susieBluePriamry)
            }
            .frame(width: 30)
            TextField(title, text: self.$text)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.words)
        }
        .frame(height: 50)
        
        if divider { Divider() }
    }
}

struct FormRowView_Previews<Content: View>: PreviewProvider {
    static var previews: some View {
        FormRowView(title: "XD", text: .constant("Hello"), content: {
            Text("XD")
        })
    }
}
