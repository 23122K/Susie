//
//  AsyncContentViewV2.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/10/2023.
//

import SwiftUI

struct AsyncContentView<T: Any, Content: View, Placeholder: View>: View {
    @Binding var state: LoadingState<T>
    var content: (T) -> Content
    var placeholder: Placeholder
    var onAppear: (() -> Void)?
    
    var body: some View {
        switch state {
        case .idle:
            Color.clear.onAppear{ onAppear?() }
        case .loading:
            placeholder
        case .failed(let error):
            Text(error.localizedDescription)
        case .loaded(let data):
            content(data)
        }
    }
    
    init(state: Binding<LoadingState<T>>, @ViewBuilder _ content: @escaping (T) -> Content, placeholder: Placeholder,  onAppear: (() -> Void)? = nil) {
        _state = state
        self.content = content
        self.placeholder = placeholder
        self.onAppear = onAppear
    }
}


typealias DefaultPlaceholder = ProgressView<EmptyView, EmptyView>
extension AsyncContentView where Placeholder == DefaultPlaceholder {
    init(state: Binding<LoadingState<T>>, @ViewBuilder _ content: @escaping (T) -> Content, onAppear: (() -> Void)? = nil) {        
        self.init(state: state, content, placeholder: ProgressView(), onAppear: onAppear)
    }
}
