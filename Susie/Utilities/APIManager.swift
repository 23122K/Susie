import Foundation

final class APIManager {
    
    internal enum Endpoint: String {
        case issue = "/api/issue"
        case project = "/api/scrum-project"
        case assignUser = "/api/scrum-project/user-association"

        //Account creation and authentication
        case signUp = "/api/auth/register"
        case signIn = "/api/auth/sign-in"
        
        //Returns information about currently logged user
        case currentUserInfo = "/api/auth/user-info"
        
        //Returns information about user with specified uuid
        //case userInfo = "/api/auth/user-info/"
    }
    
    internal enum HTTPMethod: String {
        case GET = "GET"
        case PUT = "PUT"
        case POST = "POST"
        case DELETE = "DELETE"
    }
    
    static func request(to endpoint: Endpoint, using method: HTTPMethod, data: Data) -> URLRequest {
        var request = URLRequest(url: url(for: endpoint))
        
        request.httpMethod = method.rawValue
        request.addValue("*/*", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        return request
    }
    
    static func request(to endpoint: Endpoint, using method: HTTPMethod, token: String) -> URLRequest {
        var request = URLRequest(url: url(for: endpoint))
        
        request.httpMethod = method.rawValue
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func request(to endpoint: Endpoint, using method: HTTPMethod, data: Data, token: String) -> URLRequest {
        var request = URLRequest(url: url(for: endpoint))
        
        request.httpMethod = method.rawValue
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = data
        
        return request
    }
    
    static private func url(for endpoint: Endpoint) -> URL {
        var urlComponent = URLComponents()
        
        urlComponent.scheme = "http"
        urlComponent.host = "localhost"
        urlComponent.port = 8081
        urlComponent.path = endpoint.rawValue
        return urlComponent.url!
    }
}

