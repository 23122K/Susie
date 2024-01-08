//
//  MockRequest.swift
//  Tests
//
//  Created by Patryk Maciąg on 02/12/2023.
//

import Foundation

extension URLSession {
    static var mock: URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        configuration.timeoutIntervalForResource = 1
        configuration.timeoutIntervalForRequest = 1
        return URLSession(configuration: configuration)
    }
}

final class URLProtocolMock: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return false
    }
    
    override func startLoading() {
        if let mock = URLProtocolMock.fetchMockedResponse(for: request) {
            
            if let responseStrong = mock.response {
                self.client?.urlProtocol(self, didReceive: responseStrong, cacheStoragePolicy: .notAllowed)
            }
            
            if let dataStrong = mock.data {
                self.client?.urlProtocol(self, didLoad: dataStrong)
            }
            
            //            if let errorStrong = error {
            //                self.client?.urlProtocol(self, didFailWithError: errorStrong)
            //            }
        }
        
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}

extension URLProtocolMock {
    static var mockedResponses: [MockedResponse] = []
    
    static func add(response: MockedResponse) {
        mockedResponses.append(response)
    }
    
    static func removeAllMockedResponses() {
        mockedResponses.removeAll()
    }
    
    static func fetchMockedResponse(for request: URLRequest) -> MockedResponse? {
        mockedResponses.first { response in
            response.url == request.url
        }
    }
}

struct MockedResponse {
    let url: URL
    let data: Data?
    let response: URLResponse?
}
