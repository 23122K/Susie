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
    let startTime: String //Date
    let projectID: Int32
    let active: Bool
    
    init(name: String, projectID: Int32, startTime: Date, active: Bool = false) {
        let dateFormatter = DateFormatter()
        
        self.id = -1
        self.name = name
        self.projectID = projectID
        self.startTime = dateFormatter.string(from: startTime)
        self.active = active
    }
}
