//
//  AppReducer.swift
//  Susie
//
//  Created by Patryk Maciąg on 01/12/2023.
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
        case .setUserToNil:
            state.user = nil
        case .setUserProjectToNil:
            state.project = nil
        }
    }
}
