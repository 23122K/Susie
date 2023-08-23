//
//  AuthManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

actor AuthManager {
    private var refreshTask: Task<Auth, Error>?
    
    func authorize(request: URLRequest) async throws -> URLRequest {
        let auth = try await auth
        var request = request
        request.addValue("Bearer \(auth.token)", forHTTPHeaderField: "Authorization")
        
        return request
    }
    
    internal var auth: Auth {
        get async throws {
            if let task = refreshTask {
                return try await task.value
            }
            
            guard let accessToken = try? KeychainManager.fetch(key: .accessToken) else {
                throw AuthError.authObjectIsMissing
            }
            

            guard accessToken.isValid else {
                return try await refresh()
            }
            
            return accessToken
        }
    }
    
    func refresh() async throws -> Auth {
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }
        
        guard let refreshToken = try? KeychainManager.fetch(key: .refreshToken) else {
            throw AuthError.authObjectIsMissing
        }
        
        guard refreshToken.isValid else {
            throw AuthError.couldNotRefreshAuthObject
        }
        
        let task = Task { () throws -> Auth in
            defer { refreshTask = nil }
            
            return Auth(token: "Dummy token", expiresIn: 99999)
        }
        
        self.refreshTask = task
        return try await task.value
        
    }
}
