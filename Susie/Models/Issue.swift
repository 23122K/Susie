//
//  Issue.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//


//MARK: DAO

struct Issue: Identifiable, Codable {
    let id: Int32
    let name: String
    let description: String
    let estimation: Int32
    let reporter: User
    let assignee: User?
    let backlog: Backlog
    let comments: Array<Comment>?
    let sprint: Sprint?
}

struct IssueDTO: Codable {
    let id: Int32
    let name: String
    let description: String
    let estimation: Int32
    let repoter: User
    let asignee: User
    let projectID: Int32?
    
    enum CodingKeys: String, CodingKey {
        case id = "issueID"
        case name
        case description
        case estimation
        case repoter
        case asignee
        case projectID
    }
}

struct IssueGeneralDTO: Identifiable, Codable {
    let id: Int32
    let name: String
    let asignee: User
}

struct IssueCreateRequest: Codable {
    let name: String
    let description: String
}

struct IssueUpdateRequest: Codable {
    let id: Int32
    let name: String
    let description: String
    let estimation: Int32
}


struct IssueType: Identifiable, Codable {
    let id: Int32
    let type: String
}

struct IssueStatus: Identifiable, Codable {
    let id: Int32
    let status: String
}

struct IssuePriority: Identifiable, Codable {
    let id: Int32
    let priority: String
}

