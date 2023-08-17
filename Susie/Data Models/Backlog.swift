//
//  Backlog.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

import Foundation

struct Backlog: Codable {
    let id: Int32
    let issues: Array<Issue>?
}
