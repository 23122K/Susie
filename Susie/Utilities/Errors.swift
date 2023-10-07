//
//  Errors.swift
//  Susie
//
//  Created by Patryk Maciąg on 07/10/2023.
//

import Foundation

struct APIError: Codable {
    let date: Date
    let status: Int32
    let statusDescription: String
    let description: String
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case status
        case statusDescription = "error"
        case description = "message"
        case path
    }
}

enum NetworkError: Error {
    case noInternetConnection
    case invalidHTTPResponse
    case failure(statusCode: Int)
}

enum KeychainError: Error {
    case authObjectNotFound
    case authObjectExists
    case couldNotEncodeAuthObject
    case couldNotDecodeAuthObject
    case unexpectedStatus(OSStatus)
}

enum AuthError: Error {
    case authObjectIsMissing
    case couldNotRefreshAuthObject
    
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidHTTPResponse:
            return NSLocalizedString("Recived response is invalid", comment: "")
        case let .failure(statusCode):
            return NSLocalizedString("Response status code \(statusCode)", comment: "")
        case .noInternetConnection:
            return NSLocalizedString("Device is currently offline", comment: "")
        }
    }
}
