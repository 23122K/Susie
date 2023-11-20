//
//  FromTitleView.swift
//  Susie
//
//  Created by Patryk Maciąg on 03/05/2023.
//

import SwiftUI

struct FormTitleView: View {
    let title: String
    let word: String
    
    var body: some View {
        Group(content: {
            Text(title)
            +
            Text(" ")
            +
            Text(word)
                .foregroundColor(.susieBluePriamry)
        })
        .font(.title)
        .bold()
    }
    
    init(title: String, highlighted word: String = .init()) {
        self.title = title
        self.word = word
    }
}

struct FormTitleView_Previews: PreviewProvider {
    static var previews: some View {
        FormTitleView(title: "Create your", highlighted: "team")
    }
}
