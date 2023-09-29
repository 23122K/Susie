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
//    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queries: [String: String]? { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    
//    var encoder: JSONEncoder { get }

    var schema: String { get }
    var host: String { get }
    var port: Int { get }

    var version: String { get }
}

enum Endpoints {
    private(set) static var encoder: JSONEncoder = JSONEncoder()

    internal enum AuthEndpoint: Endpoint {
        case signIn(request: SignInRequest)
        case signUp(request: SignUpRequest)
        case info
        case refresh(token: String)
        
        var schema: String { "http" }
        var host: String { "127.0.0.1" }
        var port: Int { 8081 }
        var version: String { "/api" }
        
        var headers: [String: String] {
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]
        }
        
        var path: String {
            switch self {
            case .info:
                return "auth/user-info"
            case .signIn:
                return "auth/sign-in"
            case .signUp:
                return "auth/register"
            case .refresh:
                return "auth/refresh"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .refresh, .signIn, .signUp:
                return .post
            case .info:
                return .get
            }
        }
        
        var queries: [String : String]? {
            switch self {
            case .refresh(let token):
                return ["refreshToken":"\(token)"]
            default:
                return nil
            }
            
        }
        
        var body: Data? {
            switch self {
            case .signIn(let request):
                do {
                   return try encoder.encode(request)
                } catch {
                    print(error)
                    return Data()
                }
//                return try? encoder.encode(request)
            case .signUp(let request):
                return try? encoder.encode(request)
            case .refresh, .info:
                return nil
            }
        }
    }
    internal enum IssueEndpoint: Endpoint {
        case create(issue: IssueDTO)
        case update(issue: IssueDTO)
        case delete(issue: IssueDTO)
        case fetch(project: ProjectDTO)
        case details(issue: IssueGeneralDTO)
        case assignTo(issue: IssueDTO)
        case unassignFrom(issue: IssueDTO)
        case assignedTo(sprint: Sprint)
        case change(status: IssueStatus, of: IssueDTO)
        
        var schema: String { "http" }
        var host: String { "127.0.0.1" }
        var port: Int { 8081 }
        var version: String { "/api" }
        
        var headers: [String: String] {
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]
        }
        
        var path: String {
            switch self {
            case .create, .update, .fetch :
                return "issue"
            case .details(let issue):
                return "issue/\(issue.id)"
            case .delete(let issue):
                return "issue/\(issue.id)"
            case .assignTo(issue: let issue):
                return "issue/\(issue.id)/assign"
            case .unassignFrom(issue: let issue):
                return "issue/\(issue.id)/delete-assignment"
            case .assignedTo(let sprint):
                return "issue/sprint/\(sprint.id)}"
            case .change(let status, let issue):
                return "/api/issue/\(issue.id)/status/\(status.id)"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .create, .assignTo:
                return .post
            case .update, .unassignFrom:
                return .put
            case .delete:
                return .delete
            case .fetch, .details, .assignedTo:
                return .get
            case .change:
                return .patch
            }
        }
        
        var queries: [String : String]? {
            switch self {
            case .fetch(let project):
                return ["projectID":"\(project.id)"]
            default:
                return nil
            }
        }
        
        var body: Data? {
            switch self {
            case .create(let issue), .update(let issue), .assignTo(let issue), .unassignFrom(let issue):
                return try? encoder.encode(issue)
            default:
                return nil
            }
        }
    }
    internal enum SprintEndpoint: Endpoint {
        case create(sprint: Sprint)
        //        case delete(sprint: Sprint)
        case assign(issue: IssueDTO, to: Sprint)
        case start(sprint: Sprint)
        case stop(sprint: Sprint)
        case ongoing
        case unbegun
        
        var schema: String { "http" }
        var host: String { "127.0.0.1" }
        var port: Int { 8081 }
        var version: String { "/api" }
        
        var headers: [String: String] {
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]
        }
        
        var path: String {
            switch self {
            case .create:
                return "sprint"
                //            case .delete(sprint: let sprint):
            case .assign(let issue, let sprint):
                return "sprint/\(sprint.id)/issue/\(issue.id)"
            case .start(let sprint):
                return "sprint/start/\(sprint.id)"
            case .stop(let sprint):
                return "sprint/stop/\(sprint.id)"
            case .ongoing:
                return "sprint/non-activated"
            case .unbegun:
                return "sprint/active"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .create, .assign:
                return .post
            case .start, .stop:
                return .patch
            case .ongoing, .unbegun:
                return .get
            }
        }
        
        var queries: [String : String]? { return nil }
        
        var body: Data? {
            switch self {
            case .create(let sprint):
                return try? encoder.encode(sprint)
            default:
                return nil
            }
        }
        
    }
    internal enum ProjectEndpoint: Endpoint {
        case create(project: ProjectDTO)
        case update(project: ProjectDTO)
        case delete(project: ProjectDTO)
        case fetch
        case details(project: ProjectDTO)
        case invite(request: UserAssociationDTO)
        
        var schema: String { "http" }
        var host: String { "127.0.0.1" }
        var port: Int { 8081 }
        var version: String { "/api" }
        
        var headers: [String: String] {
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]
        }
        
        var path: String {
            switch self {
            case .create, .fetch, .update:
                return "scrum-project"
            case .details(let project), .delete(let project):
                return "scrum-project/\(project.id)"
            case .invite:
                return "scrum-project/user-association"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .create, .invite:
                return .post
            case .update:
                return .put
            case .delete:
                return .delete
            case .fetch, .details:
                return .get
            }
        }
        
        var queries: [String : String]? {
            return nil
        }
        
        var body: Data? {
            switch self {
            case .create(let project), .update(let project):
                return try? encoder.encode(project)
            case .invite(let request):
                return try? encoder.encode(request)
            default:
                return nil
            }
        }
    }
    internal enum DictionaryEndpoint: Endpoint {
        case type
        case status
        case priority
        
        var schema: String { "http" }
        var host: String { "127.0.0.1" }
        var port: Int { 8081 }
        var version: String { "/api" }
        
        var headers: [String: String] {
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]
        }
        
        var path: String {
            switch self {
            case .type:
                return "dictionary/type"
            case .status:
                return "dictionary/status"
            case .priority:
                return "dictionary/priority"
            }
        }
        
        var method: HTTPMethod { return .get }
        
        var queries: [String : String]? { return nil }
        
        var body: Data? { return nil }
    }
}

//enum Endpoints: Endpoint {
//    var encoder: JSONEncoder {
//        return JSONEncoder()
//    }
//
//    //MARK: Endpoints
//    //Authentication
//    case signIn(with: SignInRequest)
//    case signUp(with: SignUpRequest)
//    case refreshToken(token: String)
//
//    //Project
//    case fetchProject(id: Int32)
//    case fetchProjects
//    case updateProject(with: ProjectDTO)
//    case createProject(with: ProjectDTO)
//    case deleteProject(id: Int32)
//    case assignToProject(email: String, projectID: Int32)
//
//    //Issue
//    ///Fetches issues assigned to project with given id
//    case fetchIssues(id: Int32)
//    case updateIssue(with: IssueDTO)
//    case createIssue(with: IssueDTO)
//    case deleteIssue(id: Int32)
//    case fetchIssueDetails(id: Int32)
//    ///Assigns particular issue specified via id to user who initiated the action
//    case assignIssue(id: Int32)
//    ///Deletes assignment of particular issue specified via id to user who initiated the action
//    case deleteIssueAssignment(id: Int32)
//
//    //Issue Dictionaries
//    case fetchIssueStatusDictionary
//    case fetchIssueTypeDictionary
//    case fetchIssuePriorityDictionary
//
//    case create(sprint: Sprint)
//    case delete(sprint: Sprint)
//    case assign(issue: IssueDTO, to: Sprint)
//    case start(sprint: Sprint)
//    case stop(sprint: Sprint)
//    case ongoing
//    case unbegun
//
//    //User
//    case currentUserInfo
//
//    var httpMethod: HTTPMethod {
//        switch self {
//        case .signUp, .signIn, .refreshToken ,.createProject, .assignToProject, .createIssue, .assignIssue, .create:
//            return .post
//        case .fetchProject, .fetchProjects, .fetchIssues, .fetchIssueDetails, .currentUserInfo, .fetchIssueTypeDictionary, .fetchIssueStatusDictionary, .fetchIssuePriorityDictionary:
//            return .get
//        case .updateProject, .updateIssue, .deleteIssueAssignment:
//            return .put
//        case .deleteProject, .deleteIssue:
//            return .delete
//        }
//    }
//
//    var schema: String { "http" }
//    var host: String { "127.0.0.1" }
//    var port: Int { 8081 }
//    var version: String { "/api" }
//
//    var path: String {
//        switch self {
//        case .signIn:
//            return "/auth/sign-in"
//        case .signUp:
//            return "/auth/register"
//        case .refreshToken:
//            return "/auth/refresh"
//        case .fetchProject(let id), .deleteProject(let id):
//            return "/scrum-project/\(id)"
//        case .fetchProjects, .updateProject, .createProject:
//            return "/scrum-project"
//        case .assignToProject:
//            return "/scrum-project/user-association"
//        case .fetchIssues, .updateIssue, .createIssue:
//            return "/issue"
//        case .fetchIssueDetails(let id):
//            return "/issue/details/\(id)"
//        case .deleteIssue(let id):
//            return "/issue/\(id)"
//        case .assignIssue(let id):
//            return "/issue/\(id)/assign"
//        case .deleteIssueAssignment(let id):
//            return "/issue/\(id)/delete-assignment"
//        case .currentUserInfo:
//            return "/auth/user-info"
//        case .fetchIssueStatusDictionary:
//            return "/dictionary/status"
//        case .fetchIssueTypeDictionary:
//            return "/dictionary/type"
//        case .fetchIssuePriorityDictionary:
//            return "/dictionary/priority"
//        }
//    }
//
//    var queries: [String:String]? {
//        switch self {
//        case .refreshToken(let token):
//            return ["refreshToken":"\(token)"]
//        case .fetchIssues(let id):
//            return ["projectID":"\(id)"]
//        default:
//            return nil
//        }
//
//    }
//
//    var body: Data? {
//        switch self {
//        case .signIn(let credentials):
//            return try? encoder.encode(credentials)
//        case .signUp(let credentials):
//            return try? encoder.encode(credentials)
//        case .createProject(let details), .updateProject(let details):
//            return try? encoder.encode(details)
//        case .createIssue(let details), .updateIssue(let details):
//            return try? encoder.encode(details)
//        default:
//            return nil
//        }
//    }
//}
