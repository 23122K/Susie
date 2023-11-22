//
//  Store.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    
    private let reducer: any Reducer<State, Action>
    
    func dispatch(_ action: Action) {
        DispatchQueue.main.async {
            self.reducer.reduce(state: &self.state, with: action)
        }
    }
    
    init(state: State, reducer: some Reducer<State, Action>) {
        self.state = state
        self.reducer = reducer
    }
}
