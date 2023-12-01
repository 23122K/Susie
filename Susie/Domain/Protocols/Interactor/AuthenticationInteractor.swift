//
//  AuthenticationInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol AuthenticationInteractor {
    var repository: any RemoteAuthRepository { get }
    
    func signIn(_ request: SignInRequest) async throws
    func signUp(_ request: SignUpRequest) async throws
    func refreshAuth(_ auth: Auth) async throws
}
