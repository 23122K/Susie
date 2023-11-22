//
//  IssueRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

import Foundation
import Factory

class RealRemoteAuthRepository: RemoteAuthRepository {
    func signIn(_ request: SignInRequest) async throws -> SignInResponse {
        let endpoint = Endpoints.AuthEndpoint.signIn(request: request)
        return try await NetworkService.request(request: endpoint.request)
    }
    
    func signUp(_ request: SignUpRequest) async throws -> SignUpResponse {
        let endpoint = Endpoints.AuthEndpoint.signUp(request: request)
        return try await NetworkService.request(request: endpoint.request)
    }
    
    func refreshAuth(_ auth: Auth) async throws -> RefreshResponse {
        let endpoint = Endpoints.AuthEndpoint.refresh(token: auth.token)
        return try await NetworkService.request(request: endpoint.request)
    }
}
