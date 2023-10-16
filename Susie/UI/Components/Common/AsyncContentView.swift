//
//  AsyncContentView.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import SwiftUI

struct AsyncContentView<Source: AsyncDataProvider, Content: View>: View {
    @ObservedObject private var source: Source
    var content: (Source.Output) -> Content
    
    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear{ source.fetch() }
        case .loading:
            Color.clear
        case .failed(let error):
            Text(error.localizedDescription)
        case .loaded(let output):
            content(output)
        }
    }
    
    init(source: Source, @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
    }
}
