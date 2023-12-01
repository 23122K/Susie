//
//  AppState.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

struct AppState: Equatable {
    var user: User?
    var project: Project?
    var scope: UserScope = .none
}
