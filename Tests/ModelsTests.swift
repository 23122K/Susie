//
//  ModelsTests.swift
//  Tests
//
//  Created by Patryk Maciąg on 25/09/2023.
//

import XCTest
@testable import Susie

final class ModelsTests: XCTestCase {
    
    func testAuthInit() throws {
        let auth = Auth(token: Mockup.Auth.token, expiresIn: 5)
        let expectedExpirationDate = Date().addingTimeInterval(5)
        
        //Auth expiration data should be equal to expextedExpirationDate
        XCTAssertTrue(Calendar.current.isDate(expectedExpirationDate, equalTo: auth.expiresAt, toGranularity: .second))
        XCTAssertEqual(auth.token, Mockup.Auth.token)
    }
    
    func testUserInit() throws {
        let user = User(email: Mockup.User.email, firstName: Mockup.User.firstName, lastName: Mockup.User.lastName)
        
        //User uuid upon creation should equal to empty string
        XCTAssertEqual(user.uuid, String())
    }
    
    func testProjectDecoder() throws {
        let decoder: JSONDecoder = JSONDecoder()
        let project = try decoder.decode(Project.self, from: Mockup.Project.data)
        
        XCTAssertEqual(project.id, Mockup.Project.id)
        XCTAssertEqual(project.name, Mockup.Project.name)
        XCTAssertEqual(project.description, Mockup.Project.description)
        XCTAssertNotNil(project.owner)
        
        //Mockut project data should return empty array of members
        XCTAssertEqual(project.members.count, 0)
    }
    
    func testProjectToDTOMethod() throws {
    let decoder: JSONDecoder = JSONDecoder()
    let project = try decoder.decode(Project.self, from: Mockup.Project.data)
    
    let projectDTO = project.toDTO()
    
    XCTAssertEqual(projectDTO.id, project.id)
    XCTAssertEqual(projectDTO.name, project.name)
    XCTAssertEqual(projectDTO.description, project.description)
}
    
    func testProjectDTOInit() throws {
        let projectDTO = ProjectDTO(name: Mockup.ProjectDTO.name, description: Mockup.ProjectDTO.description)
        
        //Transfer objects where id is not required should use negative values
        XCTAssertLessThan(projectDTO.id, 0)
        XCTAssertEqual(projectDTO.name, Mockup.ProjectDTO.name)
        XCTAssertEqual(projectDTO.description, Mockup.ProjectDTO.description)
    }
    
    func testIssueGeneralDTODecoder() thros {
        let decoder: JSONDecoder = JSONDecoder()
        let issueGeneralDTO = try decoder.decode(IssueGeneralDTO.self, from: Mockup.IssueGeneralDTO.data)
        
        XCTAssertEqual(issueGeneralDTO.id, Mockup.IssueGeneralDTO.id)
        XCTAssertEqual(issueGeneralDTO.name, Mockup.IssueGeneralDTO.name)
        XCTAssertEqual(issueGeneralDTO.issueStatusID, Mockup.IssueGeneralDTO.issueStatusID)
        
        XCTAssertNil(issueGeneralDTO.asignee)
    }
    
    func testIssueDTODecoder() throws {
        let decoder: JSONDecoder = JSONDecoder()
        let issueDTO = try decoder.decode(IssueDTO.self, from: Mockup.IssueDTO.data)
        
        XCTAssertEqual(issueDTO.id, Mockup.IssueDTO.id)
        XCTAssertEqual(issueDTO.description, Mockup.IssueDTO.description)
        XCTAssertEqual(issueDTO.estimation, Mockup.IssueDTO.estimation)
        XCTAssertEqual(issueDTO.projectID, Mockup.IssueDTO.projectID)
        XCTAssertEqual(issueDTO.issueTypeID, Mockup.IssueDTO.issueTypeID)
        XCTAssertEqual(issueDTO.issuePriorityID, Mockup.IssueDTO.issuePriorityID)
    }
    
    func testUserDecoder() throws {
        let decoder: JSONDecoder = JSONDecoder()
        let user = try decoder.decode(User.self, from: Mockup.User.data)
        
        XCTAssertEqual(user.uuid, Mockup.User.uuid)
        XCTAssertEqual(user.firstName, Mockup.User.firstName)
        XCTAssertEqual(user.lastName, Mockup.User.lastName)
        XCTAssertEqual(user.email, Mockup.User.email)
    }
    
    func testSignInRequest() throws {
        let signInRequest = SignInRequest(email: Mockup.SignInRequest.email, password: Mockup.SignInRequest.password)
        
        XCTAssertEqual(signInRequest.email, Mockup.SignInRequest.email)
    }
    
    func testSignInResponse() throws {
        let decoder: JSONDecoder = JSONDecoder()
        let signInResponse = try decoder.decode(SignInResponse.self, from: Mockup.SignInResponse.data)
        
        XCTAssertEqual(signInResponse.accessToken, Mockup.SignInResponse.accessToken)
        XCTAssertEqual(signInResponse.refreshToken, Mockup.SignInResponse.refreshToken)
        
        XCTAssertGreaterThan(signInResponse.refreshExpiresIn, signInResponse.expiresIn)
        
        XCTAssertEqual(signInResponse.userRoles.first!.name, Mockup.UserRole.name)
    }
    
    func testSignUpRequest() throws {
        let request = SignUpRequest(firstName: Mockup.User.firstName, lastName: Mockup.User.lastName, email: Mockup.User.email, password: Mockup.User.password)
        
        XCTAssertFalse(request.isScrumMaster)
    }
}
