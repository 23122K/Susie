//
//  MockRemoteRepositoryTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 02/12/2023.
//

import XCTest
@testable import Susie

final class MockRemoteRepositoryTests: XCTestCase {

    var mockRemoteRepository: MockRemoteRepository!
    
    override func setUp() {
        mockRemoteRepository = MockRemoteRepository()
    }
    
    override func tearDown() {
        URLProtocolMock.removeAllMockedResponses()
    }
    
//    func testRemoteRepositoryThorwsErrorWhenStatusCodeNotInSuccessRange() async throws {
//        //Arange
//        let response = HTTPURLResponse(url: .mock, statusCode: 401, httpVersion: nil, headerFields: nil)
//        let mockedResponse = MockedResponse(url: .mock, data: nil, response: response)
//        URLProtocolMock.add(response: mockedResponse)
//        
//    }
}

extension URL {
    static let mock = URL(string: "127.0.0.1/mock")!
}

extension URLRequest {
    static let mock = URLRequest(url: .mock)
}

