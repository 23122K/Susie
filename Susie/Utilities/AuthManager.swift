//
//  AuthManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

actor AuthManager {
    //TODO: Change object to be injectable
    private var keychain: KeychainManager = KeychainManager()
    private var refreshTask: Task<Auth, Error>?
    
    //TODO: Handle error that could be thrown here
    //TODO: Check if `refreshRequest` can be abstracted away from AuthManaager, ideally it should use NetworkManager for that request
    internal func refreshRequest(token: String) async throws -> Auth {
        let endpoint = Endpoints.refreshToken(token: token)
        let data = try await URLSession.shared.data(from: endpoint)
        
        guard let response: SignInResponse = try? JSONDecoder().decode(SignInResponse.self, from: data) else {
            print("Could not decode refresh response")
            throw AuthError.couldNotRefreshAuthObject
        }
        
        let accessAuth = Auth(token: response.accessToken, expiresIn: response.expiresIn)
        let refreshAuth = Auth(token: response.refreshToken, expiresIn: response.refreshExpiresIn)
        
        keychain[.accessAuth] = accessAuth
        keychain[.refreshAuth] = refreshAuth
        
        return accessAuth
    }
    
    
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
            
            guard let accessAuth = keychain[.accessAuth] else {
                throw AuthError.authObjectIsMissing
            }
            

            guard accessAuth.isValid else {
                return try await refresh()
            }
            
            return accessAuth
        }
    }
    
    func refresh() async throws -> Auth {
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }
        
        guard let refreshAuth = keychain[.refreshAuth] else {
            throw AuthError.authObjectIsMissing
        }
        
        guard refreshAuth.isValid else {
            throw AuthError.couldNotRefreshAuthObject
        }
        
        let task = Task { () throws -> Auth in
            defer { refreshTask = nil }
            
            return try await refreshRequest(token: refreshAuth.token)
        }
        
        self.refreshTask = task
        return try await task.value
        
    }
}
