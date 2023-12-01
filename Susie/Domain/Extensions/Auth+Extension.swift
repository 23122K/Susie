//
//  Token+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

extension Auth {
    func hasExpired(currentDate: () -> Date = { Date() } ) -> Bool {
        return expiresAt < currentDate()
    }
}

