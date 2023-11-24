//
//  AuthRepositoryProtocol.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/11/2023.
//

protocol RemoteAuthRepository: RemoteRepository {
    func signIn(_ request: SignInRequest) async throws -> SignInResponse
    func signUp(_ request: SignUpRequest) async throws -> SignUpResponse
    
    func refreshAuth(_ auth: Auth) async throws -> RefreshResponse
}
