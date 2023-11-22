//
//  Reducer.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol Reducer<State, Action> {
    associatedtype State
    associatedtype Action
    
    func reduce(state: inout State, with action: Action)
}
