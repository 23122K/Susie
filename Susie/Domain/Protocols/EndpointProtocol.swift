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
