//
//  Token.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

struct Auth: Codable {
    let token: String
    let expiresAt: Date
    
    init(token: String, expiresIn: Int32, date: () -> Date = { Date() }) {
        self.token = token
        let timeInterval = Double(expiresIn)
        self.expiresAt = date().addingTimeInterval(timeInterval)
    }
}


