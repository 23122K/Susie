//
//  CustomNavigationView.swift
//  Susie
//
//  Created by Patryk Maciąg on 07/04/2023.
//

import SwiftUI

struct CustomNavigationViewModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: button)
    }
    
    var button: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            HStack{
                Text(title)
                    .foregroundColor(.susieBluePriamry)
            }
        })
    }
}

extension View {
    func custom(title: String) -> some View {
        self.modifier(CustomNavigationViewModifier(title: title))
    }
}

