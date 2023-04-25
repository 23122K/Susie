//
//  TagView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct TagView: View {
    let tag: String
    let color: Color
    var body: some View {
        ZStack{
            Text(tag)
                .brightness(0.1)
                .foregroundColor(color)
                .bold()
                .font(.caption)
                .padding(.horizontal, 7)
                .padding(.vertical, 7)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(color)
                        .opacity(0.2)
                }
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: "BUG", color: .red)
    }
}
