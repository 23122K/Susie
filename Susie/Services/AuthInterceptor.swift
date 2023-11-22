//
//  AuthInterceptor.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/11/2023.
//

import Foundation
import Factory

actor RealAuthenticationInterceptor: AuthenticationInterceptor {
    @Injected (\.keychainManager) var keychain
    @Injected (\.authenticationInteractor) var authenticationInteractor
    
    private var refreshTask: Task<Void, Error>?
  
    func intercept(request: URLRequest) async throws -> URLRequest {
        guard let accessAuth = keychain[.accessAuth] else {
            throw AuthError.authObjectIsMissing
        }
        
        if accessAuth.hasExpired() { try await refresh() }
        
        var request = request
        request.addValue("Bearer \(accessAuth.token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    func refresh() async throws -> Void {
        if let refreshTask = refreshTask {
            try await refreshTask.value
        }
        
        guard let refreshAuth = keychain[.refreshAuth] else {
            throw AuthError.authObjectIsMissing
        }
        
        if refreshAuth.hasExpired() { throw AuthError.couldNotRefreshAuthObject }
        
        let task = Task { () throws -> Void in
            defer { refreshTask = nil }
            try await authenticationInteractor.refreshAuth(refreshAuth)
        }
        
        refreshTask = task
        return try await task.value
    }
    
}
