//
//  RemoteRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 24/11/2023.
//

import Foundation

protocol RemoteRepository {
    var session: URLSession { get }
}

enum RemoteRepositoryError: Error {
    case invalidHTTPResponse
    case failedWithStatusCode(Int)
}

extension RemoteRepository {
    func data(for request: URLRequest, interceptor: (any RequestInterceptor)? = nil) async throws -> Data {
        let request = try await interceptor?.intercept(request: request) ?? request
    
        let task = Task<Data, Error> {
            guard let (data, response) = try await session.data(for: request) as? (Data, HTTPURLResponse) else {
                throw RemoteRepositoryError.invalidHTTPResponse
            }
            
            guard (200...299).contains(response.statusCode) else {
                throw RemoteRepositoryError.failedWithStatusCode(response.statusCode)
            }
            
            return data
        }
        
        return try await task.value
    }
    
    func data(for request: URLRequest, interceptor: (any RequestInterceptor)? = nil) async throws {
        let request = try await interceptor?.intercept(request: request) ?? request
    
        let task = Task<Void, Error> {
            guard let (_, response) = try await session.data(for: request) as? (Data, HTTPURLResponse) else {
                throw RemoteRepositoryError.invalidHTTPResponse
            }
            
            guard (200...299).contains(response.statusCode) else {
                throw RemoteRepositoryError.failedWithStatusCode(response.statusCode)
            }
        }
        
        try await task.value
    }
}

extension Data {
    //TODO: - Extract decoder from this extension to ???
    private var decoder: JSONDecoder {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601
        
        return decoder
    }
    
    func decode<T: Decodable>(_ type: T.Type = T.self) async throws -> T {
        return try decoder.decode(type, from: self)
    }
}
