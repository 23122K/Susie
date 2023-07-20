import Foundation
import Combine

class HTTPClient: ObservableObject{
    
    enum APIError: String, Error {
        case invalidResponse = "Server is unavailable"
    }

    enum Endpoint: String {
        //Issues
        case updateIussue = "/api/v1/tasks/update"
        case createIussue = "/api/v1/tasks/create"
        case assignIussue = "/api/v1/tasks/assign"
        case deleteIussue = "/api/v1/tasks/delete/"
        case getIussue = "/api/v1/tasks/all" //Fetches only taks assigned to authenticated user
        
        //User
        case register = "/api/v1/auth/register"
        case authenticate = "/api/v1/auth/authenticate"
    }
    
    enum Method: String {
        case GET = "GET"
        case POST = "POST"
    }
    

    static func createRequest(_ url: URL, _ jsonData: Data) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.addValue("*/*", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        return request
    }
    
    //Overloaded createRequest
    static func createRequest(_ url: URL, _ method: Method, _ token: String) -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    static func createURL(endpoint: Endpoint) -> URL {
        var urlComponent = URLComponents()
        
        urlComponent.scheme = "http"
        urlComponent.host = "localhost"
        urlComponent.port = 8080
        urlComponent.path = endpoint.rawValue
        return urlComponent.url! //Make function throwable or change it to return Result<URL,ERROR>
    }
    
    static func fetchDataFromURL<T: Codable>(_ url: URL) -> AnyPublisher<[T], Error> {
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
    static func fetchDataFromURL<T: Codable>(_ url: URL) -> AnyPublisher<T, Error> {
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
    
    static func fetchDataFromRequest<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ result in
                guard let urlRespone = result.response as? HTTPURLResponse, (200...299).contains(urlRespone.statusCode) else {
                    throw APIError.invalidResponse
                }
                return result.data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
