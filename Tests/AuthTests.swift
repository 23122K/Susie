//
//  AuthTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 02/12/2023.
//

import XCTest
@testable import Susie

final class AuthTests: XCTestCase {
    
    var currentDate: Date!
    var token: String!
    
    override func setUp() {
        self.currentDate = Date.from(year: 2023, month: 0, day: 0, hour: 0, minute: 0, second: 0)!
        self.token = "secretToken"
    }
    
    func testAuthHadleValidityPeriodWithCorrectDate() {
        //Arrange
        let expiresIn: Int32 = 3600 //One hour expressed in seconds
        let expectedExpiresAt = Date.from(year: 2023, month: 0, day: 0, hour: 1, minute: 0, second: 0)!
        let expectedToken: String = "secretToken"
        
        //Act
        let auth = Auth(token: token, expiresIn: expiresIn, date: { currentDate })
        
        //Assert
        XCTAssertEqual(auth.token, expectedToken)
        XCTAssertEqual(auth.expiresAt, expectedExpiresAt)
    }
    
    func testAuthIsExpiredMethodExpectedTrue() {
        //Arrange
        let expiresIn: Int32 = 3600
        let pastValidityDate: Date = Date.from(year: 2023, month: 0, day: 1, hour: 0, minute: 0, second: 0)!
        
        //Act
        let auth = Auth(token: token, expiresIn: expiresIn, date: { currentDate} )
        let hasExpiredResult = auth.hasExpired { pastValidityDate }
        
        //Assert
        XCTAssertTrue(hasExpiredResult)
    }
    
    func testAuthIsExpiredMethodExpectedFalse() {
        //Arrange
        let expiresIn: Int32 = 3600
        let pastValidityDate: Date = Date.from(year: 2023, month: 0, day: 0, hour: 0, minute: 59, second: 59)!
        
        //Act
        let auth = Auth(token: token, expiresIn: expiresIn, date: { currentDate} )
        let hasExpiredResult = auth.hasExpired { pastValidityDate }
        
        //Assert
        XCTAssertFalse(hasExpiredResult)
    }
}
