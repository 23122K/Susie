//
//  Loading State.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import Foundation

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}
