//
//  UserInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

class RealUserInteractor: UserInteractor {
    var repository: RemoteUserRepository
    
    func signedUserInfo() async throws -> User {
        return try await repository.signedUserInfo()
    }
    
    init(repository: some RemoteUserRepository) {
        self.repository = repository
    }
}
