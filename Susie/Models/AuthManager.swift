//
//  AuthManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

actor AuthManager {
    private var refreshTask: Task<String, Error>?
    
    func isValid() async throws -> String {
        print("1")
        if let task = refreshTask {
            return try await task.value
        }
        
        print("2")
        guard let accessToken = try? KeychainManager.fetch(key: "accessToken") else {
            print("Not found")
            throw AuthError.tokenIsMissing
        }
        
        print("3")
        return accessToken
        //TODO: Check if token is valid, if so return it
        //Here i should check if token is still valid, for now just return true
        
        
        //return try await refreshToken() //Token has expired, refresh request is made here
    }
    
    func refreshToken() async throws -> String {
        if let refreshTask = refreshTask {
            return try await refreshTask.value
        }
        
        let task = Task { () throws -> String in
            defer { refreshTask = nil }
            
            //TODO: Make network call here to refresh token
            //If succeeds token = refreshToken
            return "Token"
        }
        
        self.refreshTask = task
        return try await task.value
        
    }
}

enum AuthError: Error {
    case tokenIsMissing
    case tokenIsInvalid
    case couldNotRefreshToken
    
}
