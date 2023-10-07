//
//  Date+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/10/2023.
//

import Foundation

extension Formatter {
    static var customISO8601DateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}

extension JSONEncoder.DateEncodingStrategy {
    static var customISO8601 = custom { date, encoder in
        let formatter = Formatter.customISO8601DateFormatter
        
        var container = encoder.singleValueContainer()
        let dateString = formatter.string(from: date)
        try container.encode(dateString)
    }
}
