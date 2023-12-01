//
//  SusieDefaults.swift
//  Susie
//
//  Created by Patryk Maciąg on 27/11/2023.
//

import Foundation

extension Int32 {
    static var `default`: Int32 { Self.init()}
}

extension String {
    static var `default`: Self { Self.init() }
    
    ///Returns random <String> in given range
    static func random(in range: Range<Int>) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = Int.random(in: range.lowerBound...range.upperBound)
        let characters = (0...length).map { _ in letters.randomElement()! }
        return String(characters)
    }
}

extension Bool {
    static var `deafult`: Self { Self.init() }
}

extension Int {
    static var `default`: Int { Self.init() }
}
