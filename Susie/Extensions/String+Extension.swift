//
//  String+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/10/2023.
//

import Foundation

extension String {
    
    ///Returns random <String> in given range
    static func random(in range: Range<Int>) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = Int.random(in: range.lowerBound...range.upperBound)
        print(length)
        let characters = (0...length).map { _ in letters.randomElement()! }
        return String(characters)
    }
}
