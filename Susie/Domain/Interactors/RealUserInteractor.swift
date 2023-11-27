//
//  UserInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation
import Factory

class RealUserInteractor: UserInteractor {
    var repository: RemoteUserRepository
    var store: AppStore
    
    func signedUserInfo() async throws {
        let user = try await repository.signedUserInfo()
        store.dispatch(.setUser(user))
    }
    
    init(repository: some RemoteUserRepository, store: AppStore) {
        self.store = store
        self.repository = repository
    }
}
