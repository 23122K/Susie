//
//  Endpoint+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 24/08/2023.
//

import Foundation

extension Endpoint {
    private var baseUrl: URL {
        var components = URLComponents()
        components.scheme = self.schema
        components.host = self.host
        components.port = self.port
        
        return components.url.unsafelyUnwrapped
    }
    
    public var url: URL {
        var url = self.baseUrl
        url.append(path: self.version)
        url.append(path: self.path)
        
        if let queries = queries {
            url.append(queryItems: queries.compactMap { query -> URLQueryItem in
                return URLQueryItem(name: query.key, value: query.value)
            })
        }
        
        return url
    }
    
    public var request: URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = self.headers
        
        if let body = self.body {
            request.httpBody = body
        }

        return request
    }
}
