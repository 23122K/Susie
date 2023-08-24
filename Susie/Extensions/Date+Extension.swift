//
//  Date+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

extension Date {
    func add(minutes: Int) -> Date {
        addingTimeInterval(Double(minutes) * 60)
    }
    
    func add(seconds: Int) -> Date {
        addingTimeInterval(Double(seconds/60) * 60)
    }
    
    
}
