//
//  DetailedRowView.swift
//  Scratchpad
//
//  Created by Patryk Maciąg on 29/04/2023.
//

import SwiftUI

struct DetailedRowView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content ) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            content
        }
        .frame(height: 30)
    }
}

struct DetailedRowView_Previews<Content: View>: PreviewProvider {
    static var previews: some View {
        DetailedRowView(title: "Issue type", content: {
            Text("Hello")
        })
    }
}

