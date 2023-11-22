//
//  RealRemoteUserRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

class RealRemoteUserRepository: RemoteUserRepository, ProtectedRepository {
    var authenticationInterceptor: AuthenticationInterceptor
    
    func signedUserInfo() async throws -> User {
        let endpoint = Endpoints.AuthEndpoint.info
        return try await NetworkService.request(request: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    init(authenticationInterceptor: some AuthenticationInterceptor) {
        self.authenticationInterceptor = authenticationInterceptor
    }
}
