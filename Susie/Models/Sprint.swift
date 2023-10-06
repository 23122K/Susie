//
//  Sprint.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//
import Foundation

struct Sprint: Identifiable, Codable {
    let id: Int32
    let name: String
    let startTime: Date?
    let projectID: Int32
    let active: Bool
    
    init(name: String, projectID: Int32, startTime: Date? = nil, active: Bool = false) {
        self.id = -1
        self.name = name
        self.projectID = projectID
        self.startTime = startTime
        self.active = active
    }
}
