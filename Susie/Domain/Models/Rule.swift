//
//  Rule.swift
//  Susie
//
//  Created by Patryk Maciąg on 04/12/2023.
//

import Foundation

struct Rule: Identifiable, Codable, Hashable {
    let id: Int32
    var definition: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "ruleID"
        case definition = "ruleName"
    }
}
