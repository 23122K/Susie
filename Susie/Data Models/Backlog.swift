//
//  Backlog.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/08/2023.
//

struct Backlog: Response {
    let id: Int32
    let issues: Array<Issue>?
}
