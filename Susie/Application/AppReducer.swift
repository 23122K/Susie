//
//  AppReducer.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

struct AppReducer: Reducer {
    func reduce(state: inout AppState, with action: AppAction) {
        switch action {
        case .authenticate:
            state.isAuthenticated = true
        case .deauthenticate:
            state.isAuthenticated = false
        }
    }
}
