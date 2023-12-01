//
//  Ednpoint.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/11/2023.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queries: [String: String]? { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    
    var schema: String { get }
    var host: String { get }
    var port: Int { get }

    var version: String { get }
}

extension Endpoint {
    var baseUrl: URL {
        var components = URLComponents()
        components.scheme = self.schema
        components.host = self.host
        components.port = self.port
        
        return components.url.unsafelyUnwrapped
    }
    
    var url: URL {
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
    
    var request: URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = self.headers
        
        if let body = self.body {
            request.httpBody = body
        }

        return request
    }
    
    //self.request.hash or Hasher() usese random seed so result difer every time app is relunched
    ///Returns a unique Endpoint identifier consisting of its `path` and `http method`
    var uid: String {
        return String.init(self.method.rawValue + self.path)
    }
}

