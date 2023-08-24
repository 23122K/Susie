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
    
    init(token: String, expiresIn: Int32) {
        self.token = token
        self.expiresAt = Date().add(minutes: Int(expiresIn))
    }
}


