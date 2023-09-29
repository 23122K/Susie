//
//  CustomSection.swift
//  Scratchpad
//
//  Created by Patryk Maciąg on 29/04/2023.
//

import SwiftUI

struct CustomSection<Content: View>: View {
    
    let content: Content
    let title: String
    let hasBorder: Bool
    
    init(title: String, bordered: Bool = true, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
        self.hasBorder = bordered
    }
    
    var body: some View {
        Text(title)
            .fontWeight(.semibold)
            .foregroundColor(Color.susieBluePriamry)
            .padding(.bottom, 0.5)
            .padding(.leading, 5)
            .offset(y: 5)
        VStack{
            content
        }
        .padding(hasBorder ? 10 : 0)
        .background{
            if(hasBorder) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.susieWhiteSecondary)
            }
        }
    }
}

struct CustomSection_Previews<Content: View>: PreviewProvider {
    static var previews: some View {
        CustomSection(title: "Test", content: {
            Text("Hello")
        })
    }
}
