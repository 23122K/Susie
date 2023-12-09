//
//  MockRemoteRepository.swift
//  Tests
//
//  Created by Patryk Maciąg on 02/12/2023.
//

import Foundation
@testable import Susie

class MockRemoteRepository: RemoteRepository {
    var session: URLSession = .mock
}
