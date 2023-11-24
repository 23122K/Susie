//
//  IssueRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

import Foundation

class RealRemoteAuthRepository: RemoteAuthRepository {
    var session: URLSession
    
    func signIn(_ request: SignInRequest) async throws -> SignInResponse {
        let endpoint = Endpoints.AuthEndpoint.signIn(request: request)
        return try await data(for: endpoint.request).decode(SignInResponse.self)
    }
    
    func signUp(_ request: SignUpRequest) async throws -> SignUpResponse {
        let endpoint = Endpoints.AuthEndpoint.signUp(request: request)
        return try await data(for: endpoint.request).decode(SignUpResponse.self)
    }
    
    func refreshAuth(_ auth: Auth) async throws -> RefreshResponse {
        let endpoint = Endpoints.AuthEndpoint.refresh(token: auth.token)
        return try await data(for: endpoint.request).decode(RefreshResponse.self)
    }
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
