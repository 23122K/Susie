//
//  Endpoint.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/08/2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol Endpoint {
    var encoder: JSONEncoder { get }

    var schema: String { get }
    var host: String { get }
    var port: Int { get }
    
    var version: String { get }
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var headers: [String: String] { get }
    var queries: [String: String]? { get }
    var body: Data? { get }
    
}

enum Endpoints: Endpoint {
    var encoder: JSONEncoder {
        return JSONEncoder()
    }
    
    //MARK: Endpoints
    //Authentication
    case signIn(with: SignInRequest)
    case signUp(with: SignUpRequest)
    case refreshToken(token: String)
    
    //Project
    case fetchProject(id: Int)
    case fetchProjects
    case updateProject(with: ProjectDTO)
    case createProject(with: ProjectDTO)
    case deleteProject(id: Int)
    case assignToProject(email: String, projectID: Int)
    
    //Issue
    ///Fetches issues assigned to project with given id
    case fetchIssues(id: Int)
    case updateIssue(with: IssueDTO)
    case createIssue(with: IssueDTO)
    case deleteIssue(id: Int)
    case fetchIssueDetails(id: Int)
    ///Assigns particular issue specified via id to user who initiated the action
    case assignIssue(id: Int)
    ///Deletes assignment of particular issue specified via id to user who initiated the action
    case deleteIssueAssignment(id: Int)
    
    //User
    case currentUserInfo
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signUp, .signIn, .refreshToken ,.createProject, .assignToProject, .createIssue, .assignIssue:
            return .post
        case .fetchProject, .fetchProjects, .fetchIssues, .fetchIssueDetails, .currentUserInfo:
            return .get
        case .updateProject, .updateIssue, .deleteIssueAssignment:
            return .put
        case .deleteProject, .deleteIssue:
            return .delete
        }
    }
    
    var schema: String { "http" }
    var host: String { "127.0.0.1" }
    var port: Int { 8081 }
    var version: String { "/api" }
    
    var path: String {
        switch self {
        case .signIn:
            return "/auth/sign-in"
        case .signUp:
            return "/auth/register"
        case .refreshToken:
            return "/auth/refresh"
        case .fetchProject(let id), .deleteProject(let id):
            return "/scrum-project/\(id)"
        case .fetchProjects, .updateProject, .createProject:
            return "/scrum-project"
        case .assignToProject:
            return "/scrum-project/user-association"
        case .fetchIssues, .updateIssue, .createIssue:
            return "/issue"
        case .fetchIssueDetails(let id):
            return "/issue/details/\(id)"
        case .deleteIssue(let id):
            return "/issue/\(id)"
        case .assignIssue(let id):
            return "/issue/\(id)/assign"
        case .deleteIssueAssignment(let id):
            return "/issue/\(id)/delete-assignment"
        case .currentUserInfo:
            return "/auth/user-info"
        }
    }
    
    var queries: [String:String]? {
        switch self {
        case .refreshToken(let token):
            return ["refreshToken":"\(token)"]
        case .fetchIssues(let id):
            return ["projectID":"\(id)"]
        default:
            return nil
        }
        
    }
    
    var headers: [String:String] {
        [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
    }
    
    var body: Data? {
        switch self {
        case .signIn(let credentials):
            return try? encoder.encode(credentials)
        case .signUp(let credentials):
            return try? encoder.encode(credentials)
        case .createProject(let details):
            return try? encoder.encode(details)
        case .updateProject(let details):
            return try? encoder.encode(details)
        case .createIssue(let details), .updateIssue(let details):
            return try? encoder.encode(details)
        default:
            return nil
        }
    }
}
