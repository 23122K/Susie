//
//  App.swift
//  Susie
//
//  Created by Patryk Maciąg on 17/11/2023.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AppFeature {
    struct State: Equatable {
        //MARK: - Root properites
        var role: UserRole = .notDetermined
        
        //MARK: - Router
        var router = StackState<Router.State>()
        
        //MARK: - States
        var welcomeState = WelcomeFeature.State()
        var signInState = SignInFeature.State()
        var signUpState = SignUpFeature.State()
    }
    
    enum Action {
        case router(StackAction<Router.State, Router.Action>)
        case welcome(WelcomeFeature.Action)
        case signIn(SignInFeature.Action)
        case signUp(SignUpFeature.Action)
    }
    
    var body: some Reducer<AppFeature.State, AppFeature.Action> {
        //MARK: - Leaf reducers to be run before root reducer
        Scope(state: \.welcomeState, action: /Action.welcome) { WelcomeFeature() }
        Scope(state: \.signInState, action: /Action.signIn) { SignInFeature() }
        Scope(state: \.signUpState, action: /Action.signUp) { SignUpFeature() }
    
        Reduce { state, action in
            switch action {
            case .welcome, .signIn, .signUp:
                return .none
            case .router:
                return .none
            }
        }
        .forEach(\.router, action: /Action.router) {
            Router()
        }
    }
    
    
    //MARK: - Routing
    
    @Reducer
    struct Router {
        enum State: Equatable {
            case welcome(WelcomeFeature.State)
            case signIn(SignInFeature.State)
            case signUp(SignUpFeature.State)
            
        }
        
        enum Action {
            case welcome(WelcomeFeature.Action)
            case signIn(SignInFeature.Action)
            case signUp(SignUpFeature.Action)
        }
        
        var body: some Reducer<Router.State, Router.Action> {
            Scope(state: /State.welcome, action: /Action.welcome) {
                WelcomeFeature()
            }
            
            Scope(state: /State.signIn, action: /Action.signIn) {
                SignInFeature()
            }
            
            Scope(state: /State.signUp, action: /Action.signUp) {
                SignUpFeature()
            }
        }
    }
}

struct AppView: View {
    var body: some View {
        NavigationStack {
            
        }
    }
}
