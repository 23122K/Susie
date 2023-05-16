//
//  PrimaryButtonView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct PrimaryButtonView: View {
    let content: String
    var body: some View {
        ZStack{
            Text(content)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.7))
                .cornerRadius(25)
                .shadow(color: Color.gray.opacity(0.3), radius: 16)
        }
        .padding(.horizontal, 20)
    
    }
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButtonView(content: "Get started")
    }
}
