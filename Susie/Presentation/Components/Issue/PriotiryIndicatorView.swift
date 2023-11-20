//
//  PriotiryIndicatorView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct TagView: View {
    private let image: Image?
    private let text: String
    private var color: Color
    private var enlarged: Bool

    var body: some View {
        HStack{
            if let image {
                image
                    .font(enlarged ? .headline : .caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            
            Text(text)
                .brightness(0.1)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(enlarged ? .headline : .caption)
        }
        .padding(.horizontal, 7)
        .padding(.vertical, 7)
        .background{
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .opacity(0.6)
        }
    }
    
    init(image: Image? = nil, text: String, color: Color, enlarged: Bool = false) {
        self.image = image
        self.enlarged = enlarged
        self.text = text
        self.color = color
    }
}

#Preview {
    TagView(image: Image(systemName: "flag"), text: "Bug", color: .red)
}
