//
//  RealRemoteUserRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

class RealRemoteUserRepository: RemoteUserRepository, ProtectedRepository {
    var session: URLSession
    var authenticationInterceptor: AuthenticationInterceptor
    
    func signedUserInfo() async throws -> User {
        let endpoint = Endpoints.AuthEndpoint.info
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode(User.self)
    }
    
    init(session: URLSession = URLSession.shared, authenticationInterceptor: some AuthenticationInterceptor) {
        self.session = session
        self.authenticationInterceptor = authenticationInterceptor
    }
}
