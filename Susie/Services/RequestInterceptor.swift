//
//  RequestInterceptor.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

import Foundation
import Alamofire

final class RequestInterceptor: Alamofire.RequestInterceptor {
    private let store: KeychainManager
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.localizedStandardContains("register") else {
            completion(.success(urlRequest))
        }
        
        guard let accessAuth = keychain[.accessAuth] else {
            completion(.failure(AuthError.authObjectIsMissing))
            throw AuthError.authObjectIsMissing
        }
        
        guard accessAuth.isValid() else {
            
        }
        
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
        
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        
        do {
            let refreshToken
        } catch {
            
        }
    }
    
    
    init(store: KeychainManager = KeychainManager()) {
        self.store = store
    }
}
