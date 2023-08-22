//
//  Sprint.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//
import Foundation

struct Sprint: Identifiable, Response {
    let id: Int32
    let name: String
    let startTime: String //Date
    let project: Project
    let sprintIssues: Array<Issue>
}

struct SprintCreationRequest: Request {
    let name: String
    let projectID: Int32
    let startTime: String //Date
    
    init(name: String, projectID: Int32, startTime: Date) {
        self.name = name
        self.projectID = projectID
        let dateFormatter = DateFormatter()
        self.startTime = dateFormatter.string(from: startTime)
    }
}
