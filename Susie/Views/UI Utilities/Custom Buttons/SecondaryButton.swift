//
//  SecondaryButton.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct SecondaryButton: View {
    let content: String
    let state: Bool
    var body: some View {
        ZStack{
            Text(content)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(state ? Color.blue.opacity(0.7) : Color.gray.opacity(0.7))
                .cornerRadius(25)
                .shadow(color: Color.gray.opacity(0.3), radius: 16)
        }
        .padding(.horizontal, 50)
    
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(content: "Click me", state: true)
    }
}
