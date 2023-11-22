//
//  AppState.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

struct AppState: Equatable {
    var isAuthenticated: Bool = false
    var user: User?
    var scope: UserScope = .none
}
