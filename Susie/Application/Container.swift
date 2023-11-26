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
    
    //MARK: - app state
    
    var appStore: Factory<AppStore> {
        self { Store(state: AppState(), reducer: AppReducer())}
            .shared
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
    
    var remoteUserRepository: Factory<RealRemoteUserRepository> {
        self { RealRemoteUserRepository(authenticationInterceptor: self.authenticationInterceptor.resolve()) }
            .singleton
    }
    
    var remoteProjectRepository: Factory<RealRemoteProjectRepository> {
        self { RealRemoteProjectRepository(authenticationInterceptor: self.authenticationInterceptor.resolve()) }
            .singleton
    }
    
    var remoteIssueRepository: Factory<RealRemoteIssueRepository> {
        self { RealRemoteIssueRepository(authenticationInterceptor: self.authenticationInterceptor.resolve()) }
            .singleton
    }
    
    var remoteSprintRepository: Factory<RealRemoteSprintRepository> {
        self { RealRemoteSprintRepository(authenticationInterceptor: self.authenticationInterceptor.resolve()) }
            .singleton
    }
    
    var remoteCommentRepository: Factory<RealRemoteCommentRepository> {
        self { RealRemoteCommentRepository(authenticationInterceptor: self.authenticationInterceptor.resolve()) }
            .singleton
    }
    
    //MARK: - interactors
    
    var authenticationInteractor: Factory<RealAuthenticationInteractor> {
        self { RealAuthenticationInteractor(repository: self.remoteAuthRepository.resolve()) }
            .singleton
    }
    
    var projectInteractor: Factory<RealProjectInteractor> {
        self { RealProjectInteractor(repository: self.remoteProjectRepository.resolve()) }
            .singleton
    }
    
    var userInteractor: Factory<RealUserInteractor> {
        self { RealUserInteractor(repository: self.remoteUserRepository.resolve()) }
            .singleton
    }
    
    var issueInteractor: Factory<RealIssueInteractor> {
        self { RealIssueInteractor(repository: self.remoteIssueRepository.resolve() )}
    }
    
    var sprintInteractor: Factory<RealSprintInteractor> {
        self { RealSprintInteractor(repository: self.remoteSprintRepository.resolve() )}
    }
    
    var commentInteractor: Factory<RealCommentInteractor> {
        self { RealCommentInteractor(repository: self.remoteCommentRepository.resolve() )}
    }
}
