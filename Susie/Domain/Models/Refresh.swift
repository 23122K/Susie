//
//  Refresh.swift
//  Susie
//
//  Created by Patryk Maciąg on 26/10/2023.
//

import Foundation

struct RefreshResponse: Codable {
    let accessToken: String
    let refreshToken: String
    
    let expiresIn: Int32
    let refreshExpiresIn: Int32
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case refreshExpiresIn = "refresh_expires_in"
    }
}
