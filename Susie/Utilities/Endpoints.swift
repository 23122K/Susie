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

extension Endpoint {
    internal var baseUrl: URL {
        var components = URLComponents()
        components.scheme = self.schema
        components.host = self.host
        components.port = self.port
        
        return components.url.unsafelyUnwrapped
    }
    
    public var url: URL {
        var url = self.baseUrl
        url.append(path: self.version)
        url.append(path: self.path)
        
        if let queries = queries {
            url.append(queryItems: queries.compactMap { query -> URLQueryItem in
                return URLQueryItem(name: query.key, value: query.value)
            })
        }
        
        return url
    }
    
    public var request: URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = self.headers
        
        if let body = self.body {
            request.httpBody = body
        }

        return request
    }
    
}

enum Endpoints: Endpoint {
    var encoder: JSONEncoder {
        return JSONEncoder()
    }
    
    //MARK: Endpoints
    //Authentication
    case signIn(with: SignInRequest)
    case signUp(with: SignUpRequest)
    
    //Project
    case fetchProject(id: Int, token: String)
    case fetchProjects(token: String)
    case updateProject(with: ProjectDTO, token: String)
    case createProject(with: ProjectDTO, token: String)
    case deleteProject(id: Int, token: String)
    case assignToProject(email: String, projectID: Int, token: String)
    
    //Issue
    ///Fetches issues assigned to project with given id
    case fetchIssues(id: Int, token: String)
    case updateIssue(with: IssueDTO, token: String)
    case createIssue(with: IssueDTO, token: String)
    case deleteIssue(id: Int, token: String)
    case fetchIssueDetails(id: Int, token: String)
    ///Assigns particular issue specified via id to user who initiated the action
    case assignIssue(id: Int, token: String)
    ///Deletes assignment of particular issue specified via id to user who initiated the action
    case deleteIssueAssignment(id: Int, token: String)
    
    //User
    case currentUserInfo(token: String)
    
    var httpMethod: HTTPMethod {
        switch self {
        case .signUp, .signIn, .createProject, .assignToProject, .createIssue, .assignIssue:
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
    var version: String {
        return "/api"
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/auth/sign-in"
        case .signUp:
            return "/auth/register"
        case .fetchProject(let id, _), .deleteProject(let id, _):
            return "/scrum-project/\(id)"
        case .fetchProjects, .updateProject, .createProject:
            return "/scrum-project"
        case .assignToProject:
            return "/scrum-project/user-association"
        case .fetchIssues, .updateIssue, .createIssue:
            return "/issue"
        case .fetchIssueDetails(let id, _):
            return "/issue/details/\(id)"
        case .deleteIssue(let id, _):
            return "/issue/\(id)"
        case .assignIssue(let id, _):
            return "/issue/\(id)/assign"
        case .deleteIssueAssignment(let id, _):
            return "/issue/\(id)/delete-assignment"
        case .currentUserInfo:
            return "/auth/user-info"
        }
    }
    
    var queries: [String:String]? {
        switch self {
        case .fetchIssues(let id, _):
            return ["projectID":"\(id)"]
        default:
            return nil
        }
        
    }
    
    var headers: [String:String] {
        var headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
        
        switch self {
        case .signIn, .signUp:
            break
        case .fetchProject(_, let token), .fetchProjects(let token), .createProject(_, let token) ,.updateProject(_, let token), .deleteProject(_, let token):
            headers["Authorization"] = "Bearer \(token)"
        case .fetchIssues(_, let token), .updateIssue(_, let token), .createIssue(_, let token), .deleteIssue(_, let token), .fetchIssueDetails(_, let token):
            headers["Authorization"] = "Bearer \(token)"
        case .assignToProject(_, _, let token), .assignIssue(_, let token), .deleteIssueAssignment(_, let token):
            headers["Authorization"] = "Bearer \(token)"
        case .currentUserInfo(let token):
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    
    var body: Data? {
        switch self {
        case .signIn(let credentials):
            return try? encoder.encode(credentials)
        case .signUp(let credentials):
            return try? encoder.encode(credentials)
        case .createProject(let details, _), .updateProject(let details, _):
            return try? encoder.encode(details)
        case .createIssue(let details, _), .updateIssue(let details, _):
            return try? encoder.encode(details)
        default:
            return nil
        }
    }
}
