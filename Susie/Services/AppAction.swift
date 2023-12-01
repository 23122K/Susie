//
//  AppAction.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

enum AppAction {
    case setUser(User)
    case setUserVisibilityScope(UserScope)
    case setUserProject(Project)
    case setUserToNil
    case setUserProjectToNil
}
