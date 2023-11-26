//
//  UserInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation
import Factory

class RealUserInteractor: UserInteractor {
    @Injected (\.appStore) private var store
    
    var repository: RemoteUserRepository
    
    func signedUserInfo() async throws {
        let user = try await repository.signedUserInfo()
        store.dispatch(.setUser(user))
    }
    
    init(repository: some RemoteUserRepository) {
        self.repository = repository
    }
}
