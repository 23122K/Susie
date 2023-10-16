//
//  IssueType.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/10/2023.
//

import SwiftUI

protocol Tag: RawRepresentable, CaseIterable, Hashable, Codable{
    var description: String { get }
    var color: Color { get }
}

enum IssueType: Int32, Tag {
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
