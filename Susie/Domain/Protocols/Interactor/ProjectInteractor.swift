//
//  ProjectInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol ProjectInteractor {
    var repository: any RemoteProjectRepository { get }
    
    func fetch() async throws -> Array<ProjectDTO>
    func update(project: ProjectDTO) async throws
    func create(project: ProjectDTO) async throws
    func delete(project: ProjectDTO) async throws
    func details(of project: ProjectDTO) async throws
    func sendInvitation(invitation: InviteRequest) async throws
    func remove(user: User, from project: ProjectDTO) async throws
}
