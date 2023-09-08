//
//  NetworkError.swift
//  Susie
//
//  Created by Patryk Maciąg on 18/08/2023.
//

import Foundation

enum NetworkError: Error {
    case noInternetConnection
    case invalidHTTPResponse
    case failure(statusCode: Int)
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
