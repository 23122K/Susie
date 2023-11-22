//
//  NetworkService.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/11/2023.
//

import Foundation

final class NetworkService {
    
    //TODO: Fix
    //I guess, below code breaks the Single responsibility principle
    private static var decoder: JSONDecoder = {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601
        
        return decoder
    }()
    
    static func request<T: Codable>(request: URLRequest, interceptor: (any RequestInterceptor)? = nil) async throws -> T {
        let request = try await interceptor?.intercept(request: request) ?? request
    
        let task = Task<Data, Error> {
            guard let (data, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
                throw NetworkError.invalidHTTPResponse
            }
            
            guard (200...299).contains(response.statusCode) else {
                throw NetworkError.failedWithStatusCode(response.statusCode)
            }
            
            return data
        }
        
        let data = try await task.value
        return try decoder.decode(T.self, from: data)
    }
    
    static func request(request: URLRequest, interceptor: (any RequestInterceptor)? = nil) async throws {
        let request = try await interceptor?.intercept(request: request) ?? request
    
        let task = Task<Void, Error> {
            guard let (_, response) = try await URLSession.shared.data(for: request) as? (Data, HTTPURLResponse) else {
                throw NetworkError.invalidHTTPResponse
            }
            
            guard (200...299).contains(response.statusCode) else {
                throw NetworkError.failedWithStatusCode(response.statusCode)
            }
        }
        
        try await task.value
    }
}
