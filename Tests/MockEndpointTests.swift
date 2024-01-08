//
//  MockEndpointTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 02/12/2023.
//

import XCTest
@testable import Susie

final class MockEndpointTests: XCTestCase {
    

    func testEndpointCases() {
        //Arrange
        let expectedHost = "0.0.0.0"
        let expectedSchema = "http"
        let expectedPort = 0
        let expectedVesion = "/test"
        
        //Act
        let endpoint: MockEndpoint = .create
        
        //Assert
        XCTAssertEqual(endpoint.host, expectedHost)
        XCTAssertEqual(endpoint.schema, expectedSchema)
        XCTAssertEqual(endpoint.port, expectedPort)
        XCTAssertEqual(endpoint.version, expectedVesion)
    }
}
