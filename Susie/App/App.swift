//
//  App.swift
//  Susie
//
//  Created by Patryk Maciąg on 17/11/2023.
//


import ComposableArchitecture
import SwiftUI

enum UserRole: Equatable {
    case notDetermined
    case sm
    case po
    case dev
}

struct AppFeature: Reducer {
    struct State: Equatable {
        var role: UserRole = .notDetermined
        
    }
    
    enum Action: Equatable {
        
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
            
        }
    }
}

struct AppView: View {
    var body: some View {
        NavigationStack {
            
        }
    }
}

#Preview {
    App()
}
