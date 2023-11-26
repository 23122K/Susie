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
    
    @Injected(\.appStore) var store
    @Injected(\.keychainManager) var keychain
    
    func signIn(_ request: SignInRequest) async throws {
        let response = try await repository.signIn(request)
        
        keychain[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        keychain[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
    }
    
    func signUp(_ request: SignUpRequest) async throws {
        let _ = try await repository.signUp(request)
        
        let request = SignInRequest(email: request.email, password: request.password)
        try await signIn(request)
    }
    
    func refreshAuth(_ auth: Auth) async throws {
        let response = try await repository.refreshAuth(auth)
        
        keychain[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        keychain[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
    }
    
    init(repository: some RemoteAuthRepository) {
        self.repository = repository
    }
}
