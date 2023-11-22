//
//  AuthInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/11/2023.
//

import Foundation
import Factory

protocol AuthenticationInteractor {
    var authenticationRepository: any RemoteAuthRepository { get }
}

class RealAuthenticationInteractor: AuthenticationInteractor {
    var authenticationRepository: RemoteAuthRepository
    @Injected(\.keychainManager) var keychain
    
    func signIn(_ request: SignInRequest) async throws {
        let response = try await authenticationRepository.signIn(request)
        
        keychain[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        keychain[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
        
    }
    
    func signUp(_ request: SignUpRequest) async throws {
        let _ = try await authenticationRepository.signUp(request)
    }
    
    func refreshAuth(_ auth: Auth) async throws {
        let response = try await authenticationRepository.refreshAuth(auth)
        
        keychain[.accessAuth] = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        keychain[.refreshAuth] = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
    }
    
    init(authenticationRepository: some RemoteAuthRepository) {
        self.authenticationRepository = authenticationRepository
    }
}
