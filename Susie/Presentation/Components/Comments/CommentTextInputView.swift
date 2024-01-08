//
//  CommentTextInputView.swift
//  Susie
//
//  Created by Patryk Maciąg on 23/10/2023.
//

import SwiftUI

struct CommentTextInputView: View {
    @Binding var text: String
    let onSubmit: () -> Void
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        HStack {
            TextField("\(.localized.addComment)", text: $text)
                .onSubmit { 
                    onSubmit()
                    hideKeyboard()
                }
            
            Spacer()
            
            Button(action: { 
                hideKeyboard()
            }, label: {
                Image(systemName: "x.circle.fill")
                    .foregroundColor(.gray)
            })
        }
        .frame(height: 50)
        .foregroundStyle(Color.susieBluePriamry)
        .ignoresSafeArea(.keyboard)
    }
    
    init(text: Binding<String>, onSubmit: @escaping () -> Void) {
        _text = text
        self.onSubmit = onSubmit
    }
}
