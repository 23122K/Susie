//
//  ProjectDTORepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/11/2023.
//

import Foundation

protocol RemoteProjectRepository: RemoteRepository {
    func fetch() async throws -> Array<ProjectDTO>
    func update(project: ProjectDTO) async throws
    func create(project: ProjectDTO) async throws
    func delete(project: ProjectDTO) async throws
    
    func details(of project: ProjectDTO) async throws -> Project
    func invite(invitation: InviteRequest) async throws
    func remove(user: User, from project: ProjectDTO) async throws
}
