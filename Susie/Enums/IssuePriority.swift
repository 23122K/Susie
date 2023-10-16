//
//  IssuePriority.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/10/2023.
//

import SwiftUI

enum IssuePriority: Int32, Tag {
    case critical = 1
    case high = 2
    case medium = 3
    case low = 4
    case trivial = 5
    
    var description: String {
        switch self {
        case .critical:
            return "Critical"
        case .high:
            return "High"
        case .medium:
            return "Medium"
        case .low:
            return "Low"
        case .trivial:
            return "Trivial"
        }
    }
    
    var color: Color {
        switch self {
        case .critical:
            return .red
        case .high:
            return.orange
        case .medium:
            return.yellow
        case .low:
            return .green
        case .trivial:
            return .blue
        }
    }
}
