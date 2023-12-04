//
//  FromRowView.swift
//  Susie
//
//  Created by Patryk Maciąg on 03/05/2023.
//

import SwiftUI

struct CustomTextField<T: Hashable, Content: View>: View {
    @Binding private var text: String
    private var focus: FocusState<T>.Binding
    private var field: T
    
    private let title: LocalizedStringResource
    private let content: Content
    private let keyboardType: UIKeyboardType
    
    var body: some View {
        HStack(spacing: 15){
            ZStack{
                content
                    .foregroundColor(.susieBluePriamry)
            }
            .frame(width: 30)
            
            TextField("\(title)", text: $text)
                .focused(focus, equals: field)
                .keyboardType(keyboardType)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(keyboardType == .emailAddress ? .never : .sentences)
        }
        .frame(height: 50)
        
    }
    
    init(title: LocalizedStringResource, text: Binding<String>, keyboard type: UIKeyboardType, focus: FocusState<T>.Binding, equals field: T,
         @ViewBuilder _ content: () -> Content) {
        _text = text
        self.focus = focus
        self.field = field
        self.title = title
        self.content = content()
        self.keyboardType = type
    }
}
