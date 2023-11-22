//
//  Token+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

extension Auth {
    //Checks if auth expiration date is past the current date, if so token has not yet expired
    //e.g. 2023-08-22 17:34:53 +0000 > 2023-08-22 14:50:10 +0000 -> True
    func isValid(currentDate: () -> Date = { Date() } ) -> Bool {
        return expiresAt > currentDate()
    }
    
    func hasExpired(currentDate: () -> Date = { Date() } ) -> Bool {
        return expiresAt < currentDate()
    }
}

