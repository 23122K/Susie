//
//  Container.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import Foundation
import Factory

extension Container {
    var client: Factory<Client> {
        self { Client() }
            .singleton
    }
    
    var store: Factory<Store<AppState, AppAction>> {
        self { Store(state: AppState(), reducer: AppReducer())}
            .shared
    }
    
    var appState: Factory<AppState> {
        self { AppState(isAuthenticated: false) }
    }
    
    var keychainManager: Factory<KeychainManager> {
        self { KeychainManager() }
            .singleton
    }
    
    var authenticationInterceptor: Factory<RealAuthenticationInterceptor> {
        self { RealAuthenticationInterceptor() }
            .singleton
    }
    
    //MARK: - repositories
    
    var remoteAuthRepository: Factory<RealRemoteAuthRepository> {
        self { RealRemoteAuthRepository() }
            .singleton
    }
    
    var remoteProjectDTORepository: Factory<RemoteProjectDTORepository> {
        self { RemoteProjectDTORepository(authenticationInterceptor: self.authenticationInterceptor.resolve()) }
            .singleton
    }
    
    //MARK: - interactors
    
    var authenticationInteractor: Factory<RealAuthenticationInteractor> {
        self { RealAuthenticationInteractor(authenticationRepository: self.remoteAuthRepository.resolve()) }
            .singleton
    }
}
