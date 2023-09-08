//
//  TagView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct IssueTypeView: View {
    let content: String
    let color: Color
    var body: some View {
        ZStack{
            Text(content)
                .fontWeight(.heavy)
                .brightness(0.1)
                .foregroundColor(color)
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

struct IssueType_View: PreviewProvider {
    static var previews: some View {
        IssueTypeView(content: "BUG", color: .red)
    }
}
