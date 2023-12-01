//
//  RemoteUserRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol RemoteUserRepository: RemoteRepository {
    func signedUserInfo() async throws -> User

    //TODO: - implement
    //func delete() async throws
    //func grantPermission(project: ProjectDTO, user: User, role: UserRole) async throws
    //func revokePermission(project: ProjectDTO, user: User, role: UserRole) async throws
}
