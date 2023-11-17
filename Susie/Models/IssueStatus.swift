//
//  IssueStatus.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/10/2023.
//

import Foundation
import SwiftUI

enum IssueStatus: Int32, Tag {
    case toDo = 1
    case inProgress = 2
    case inReview = 3
    case inTests = 4
    case done = 5
    
    var description: String {
        switch self {
        case .toDo:
            return "To do"
        case .inProgress:
            return "In progress"
        case .inReview:
            return "Code review"
        case .inTests:
            return "In tests"
        case .done:
            return "Done"
        }
    }
    
    var color: Color {
        return Color.susieBluePriamry
    }
}
