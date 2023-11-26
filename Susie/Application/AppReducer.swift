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
        case let .setUser(user):
            state.user = user
        case let .setUserVisibilityScope(scope):
            state.scope = scope
        case let .setUserProject(project):
            state.project = project
        }
    }
}
