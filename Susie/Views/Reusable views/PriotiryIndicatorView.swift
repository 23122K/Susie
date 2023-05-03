//
//  PriotiryIndicatorView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct PriotiryIndicatorView: View {
    let color: Color
    let text: String
    var body: some View {
        HStack{
            Image(systemName: "flag.fill")
                .font(.caption)
                .bold()
                .foregroundColor(.white)
            Text(text)
                .brightness(0.1)
                .foregroundColor(.white)
                .bold()
                .font(.caption)
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 7)
        .background{
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .opacity(0.6)
        }
        
    }
}

struct PriotiryIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        PriotiryIndicatorView(color: .orange, text: "Medium")
    }
}
