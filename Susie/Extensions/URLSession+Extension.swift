//
//  URLSession+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 23/08/2023.
//

import Foundation

extension URLSession {
    func data(from endpoint: Endpoint) async throws -> Data {
        guard let (data, response) = try await URLSession.shared.data(for: endpoint.request) as? (Data, HTTPURLResponse) else {
            throw NetworkError.invalidHTTPResponse
        }
        
        guard (200...299).contains( response.statusCode ) else {
            throw NetworkError.failure(statusCode: response.statusCode)
        }
        
        return data
    }
}
