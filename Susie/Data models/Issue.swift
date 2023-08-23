//
//  Issue.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

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
    let issueID: Int32
    let name: String
    let description: String
    let estimation: Int32
    let repoter: User
    let asignee: User
    let projectID: Int32?
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
