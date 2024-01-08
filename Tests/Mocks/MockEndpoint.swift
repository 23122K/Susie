//
//  MockEndpoint.swift
//  Tests
//
//  Created by Patryk Maciąg on 02/12/2023.
//

import Foundation
@testable import Susie

enum MockEndpoint: Endpoint {
    case create
    case fetch
    case update
    case delete
    
    var schema: String { "http" }
    var host: String { "0.0.0.0" }
    var port: Int { 0 }
    var version: String { "/test" }
    
    var headers: [String: String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
    }
    
    var path: String {
        switch self {
        case .create, .fetch, .update, .delete:
            return "mock"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        case .update:
            return .put
        case .fetch:
            return .get
        case .delete:
            return .delete
        }
    }
    
    var queries: [String : String]? {
        switch self {
        case .delete:
            return ["mock": "mock"]
        default:
            return nil
        }
    }
    
    var body: Data? { return nil }
}
