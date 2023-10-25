//
//  Loading State.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import Foundation

enum Loadable<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
    
    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .failed(error): return error
        default: return nil
        }
    }
}
