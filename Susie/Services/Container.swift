//
//  Container.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import Foundation
import Factory

extension Container {
    //MARK: - app state
    
    var appStore: Factory<AppStore> {
        self { Store(state: AppState(), reducer: AppReducer())}
            .shared
    }
    
    var authStore: Factory<KeychainStore> {
        self { KeychainStore() }
            .singleton
    }
    
    //MARK: - interceptors
    
    var authenticationInterceptor: Factory<RealAuthenticationInterceptor> {
        self { RealAuthenticationInterceptor(authenticationInteractor: self.authenticationInteractor.resolve(), authStore: self.authStore.resolve()) }
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
    
    var remoteCommitmentRuleRepository: Factory<RealCommitmentRuleRemoteRepository> {
        self { RealCommitmentRuleRemoteRepository(authenticationInterceptor: self.authenticationInterceptor.resolve()) }
            .singleton
    }
    
    //MARK: - interactors
    
    var authenticationInteractor: Factory<RealAuthenticationInteractor> {
        self { RealAuthenticationInteractor(repository: self.remoteAuthRepository.resolve(), appStore: self.appStore.resolve(), authStore: self.authStore.resolve()) }
            .singleton
    }
    
    var projectInteractor: Factory<RealProjectInteractor> {
        self { RealProjectInteractor(repository: self.remoteProjectRepository.resolve(), store: self.appStore.resolve()) }
            .singleton
    }
    
    var userInteractor: Factory<RealUserInteractor> {
        self { RealUserInteractor(repository: self.remoteUserRepository.resolve(), store: self.appStore.resolve()) }
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
    
    var commitmentRuleInteracotr: Factory<RealCommitmentRuleInteractor> {
        self { RealCommitmentRuleInteractor(repository: self.remoteCommitmentRuleRepository.resolve()) }
    }
}
