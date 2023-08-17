import Foundation
import Combine

final class APIManager {
    enum APIError: Error {
        case invalidResponse
    }

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
        case userInfo = "/api/auth/user-info/"
    }
    
    internal enum HTTPMethod: String {
        case GET = "GET"
        case PUT = "PUT"
        case POST = "POST"
        case DELETE = "DELETE"
    }
    
    
    static func createRequest(to endpoint: URL, method: HTTPMethod, payload: Data) -> URLRequest {
        var request = URLRequest(url: endpoint)
        
        request.httpMethod = method.rawValue
        request.addValue("*/*", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload
        
        return request
    }
    
    static func createRequest(to endpoint: URL, using method: HTTPMethod, token: String) -> URLRequest {
        var request = URLRequest(url: endpoint)
        
        request.httpMethod = method.rawValue
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func createRequest(to endpoint: URL, using method: HTTPMethod, payload: Data, token: String) -> URLRequest {
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = payload
        
        return request
    }
    
    static func createURL(for endpoint: Endpoint) -> URL {
        var urlComponent = URLComponents()
        
        urlComponent.scheme = "http"
        urlComponent.host = "localhost"
        urlComponent.port = 8081
        urlComponent.path = endpoint.rawValue
        return urlComponent.url!
    }
    
    //MARK: Methods to help fetch data
    static func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<[T], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ result in
                let decoder = JSONDecoder()
                guard let urlRespone = result.response as? HTTPURLResponse, (200...299).contains(urlRespone.statusCode) else {
                    throw APIError.invalidResponse
                }
                
                return try decoder.decode([T].self, from: result.data)
            })
            .eraseToAnyPublisher()
    }
    
    //Takes a single Type as its parametter
    static func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ result in
                let decoder = JSONDecoder()
                guard let urlRespone = result.response as? HTTPURLResponse, (200...299).contains(urlRespone.statusCode) else {
                    throw APIError.invalidResponse
                }
                return try decoder.decode(T.self, from: result.data)
            })
            .eraseToAnyPublisher()
    }
    
    static func fetchData<T: Decodable>(from request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ result in
                guard let urlRespone = result.response as? HTTPURLResponse, (200...299).contains(urlRespone.statusCode) else {
                    let code = result.response as! HTTPURLResponse
                    print(code.statusCode)
                    throw APIError.invalidResponse
                }
                return result.data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

