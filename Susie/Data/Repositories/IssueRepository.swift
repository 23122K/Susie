//
//  IssueRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

import Foundation

protocol AuthRepository {
    func signIn(_ request: SignInRequest) -> SignUpResponse
    func signUp(_ request: SignUpRequest) -> SignUpResponse
    
    func refreshToken(_ auth: Auth)
}


//class RemoteAuthRepository: AuthRepository {
//    
//    func signIn(_ request: SignInRequest) -> SignUpResponse {
//        let request = Endpoints.AuthEndpoint.signIn(request: request)
//        
//    }
//    
//    func signUp(_ request: SignUpRequest) -> SignUpResponse {
//        let request = Endpoints.AuthEndpoint.signUp(request: request)
//    }
//    
//    func refreshToken(_ auth: Auth) {
//        let request = Endpoints.AuthEndpoint.refresh(token: auth.token)
//    }
//}
