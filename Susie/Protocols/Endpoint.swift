//
//  Endpoint.swift
//  Susie
//
//  Created by Patryk Maciąg on 24/08/2023.
//

import Foundation

protocol Endpoint {
    var encoder: JSONEncoder { get }

    var schema: String { get }
    var host: String { get }
    var port: Int { get }
    
    var version: String { get }
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var headers: [String: String] { get }
    var queries: [String: String]? { get }
    var body: Data? { get }
}
