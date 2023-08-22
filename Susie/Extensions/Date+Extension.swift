//
//  Date+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

extension Date {
    func addMinutes(_ minutes: Int32) -> Date {
        addingTimeInterval(Double(minutes) * 60)
    }
}
