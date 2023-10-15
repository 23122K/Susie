//
//  IssueType.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/10/2023.
//

import SwiftUI

enum IssueType: Int32, RawRepresentable, CaseIterable, Codable {
    case userStory = 1
    case bug = 2
    case toDo = 3
    case aoa = 4
    
    var description: String {
        switch self {
        case .bug:
            return "Bug"
        case .userStory:
            return "User story"
        case .toDo:
            return "To Do"
        case .aoa:
            return "Agile assignment"
        }
    }
    
    var color: Color {
        switch self {
        case .userStory:
            return .cyan
        case .bug:
            return .red
        case .toDo:
            return .green
        case .aoa:
            return .orange
        }
    }
}
