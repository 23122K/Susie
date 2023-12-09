//
//  DateMock.swift
//  Tests
//
//  Created by Patryk Maciąg on 03/12/2023.
//

import Foundation

extension Date {
    static func from(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        return calendar.date(from: dateComponents) ?? nil
    }
 }
