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
            case .welcome(.signInButtonTapped):
                state.router.append(.signIn(state.signInState))
                return .none
                
            case .welcome(.signUpButtonTapped):
                state.router.append(.signUp(state.signUpState))
                return .none
                
//            case .signUp(.nextButtonTapped):
//                state.router.append(.signUpFinalization(state.signUpState))
//                return .none
//    
            case .welcome, .signIn, .signUp:
                return .none
                
            case .router(.element(id: _, action: .signUp(.nextButtonTapped))):
                state.router.append(.signUpFinalization(state.signUpState))
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
            case signUpFinalization(SignUpFeature.State)
            
        }
        
        enum Action {
            case welcome(WelcomeFeature.Action)
            case signIn(SignInFeature.Action)
            case signUp(SignUpFeature.Action)
            case signUpFinalization(SignUpFeature.Action)
        }
        
        var body: some ReducerOf<Self> {
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
    let store: StoreOf<AppFeature>
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.router, action: { .router($0) })) {
            WithViewStore(store, observe: \.role) { viewStore in
                WelcomeView(store: store.scope(state: \.welcomeState, action: { .welcome($0) }))
            }
        } destination: { state in
            switch state {
            case .welcome:
                CaseLet(/AppFeature.Router.State.welcome, action: AppFeature.Router.Action.welcome) { store in
                    WelcomeView(store: store)
                }
            case .signIn:
                CaseLet(/AppFeature.Router.State.signIn, action: AppFeature.Router.Action.signIn) { store in
                    SignInView(store: store)
                }
            case .signUp:
                CaseLet(/AppFeature.Router.State.signUp, action: AppFeature.Router.Action.signUp) { store in
                    SignUpView(store: store)
                }
            case .signUpFinalization:
                CaseLet(/AppFeature.Router.State.signUpFinalization, action: AppFeature.Router.Action.signUpFinalization) { store in
                    SignUpFinalizationView(store: store)
                }
            }
        }
    }
}

#Preview {
    AppView(store: Store(initialState: AppFeature.State()) {
      AppFeature()
    })
}
