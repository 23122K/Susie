//
//  AuthInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/11/2023.
//

import Foundation
import Factory


class RealAuthenticationInteractor: AuthenticationInteractor {
    var repository: RemoteAuthRepository
    var appStore: AppStore
    var authStore: AuthStore
    
    func signIn(_ request: SignInRequest) async throws {
        let response = try await repository.signIn(request)
        
        authStore[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        authStore[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
    }
    
    func signUp(_ request: SignUpRequest) async throws {
        let _ = try await repository.signUp(request)
        
        let request = SignInRequest(email: request.email, password: request.password)
        try await signIn(request)
    }
    
    func refreshAuth(_ auth: Auth) async throws {
        let response = try await repository.refreshAuth(auth)
        
        authStore[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        authStore[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
    }
    
    init(repository: some RemoteAuthRepository, appStore: AppStore, authStore: some AuthStore) {
        self.appStore = appStore
        self.authStore = authStore
        self.repository = repository
    }
}
