//
//  Token.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

struct Token {
    enum TokenError: Error {
        case invalidDateFormat
    }
    
    let key: String
    let expiresAt: Date
    
    init(key: String, expiresAt: String) throws {
        let dateFormatter = DateFormatter()
        guard let data = dateFormatter.date(from: expiresAt) else {
            throw TokenError.invalidDateFormat
        }
        
        self.key = key
        self.expiresAt = data
    }
}
