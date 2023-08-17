//
//  Comment.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

import Foundation

struct Comment: Identifiable, Codable {
    var id: Int32
    var title: String
    var body: String
    var issue: Issue
    var userID: String
}
