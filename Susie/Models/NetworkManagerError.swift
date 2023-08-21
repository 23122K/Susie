//
//  NetworkManagerError.swift
//  Susie
//
//  Created by Patryk Maciąg on 18/08/2023.
//

import Foundation

enum NetworkManagerError: Error {
    case invalidHttpResponse
    case failure(statusCode: Int)
}

extension NetworkManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidHttpResponse:
            return NSLocalizedString("Recived response is invalid", comment: "")
        case let .failure(statusCode):
            return NSLocalizedString("Response status code \(statusCode)", comment: "")
        }
    }
}
