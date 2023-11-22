//
//  RealProjectInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

class RealProjectInteractor: ProjectInteractor {
    var repository: RemoteProjectRepository
    
    func fetch() async throws -> Array<ProjectDTO> {
        return try await repository.fetch()
    }
    
    func update(project: ProjectDTO) async throws {
        try await repository.update(project: project)
    }
    
    func create(project: ProjectDTO) async throws {
        try await repository.create(project: project)
    }
    
    func delete(project: ProjectDTO) async throws {
        try await repository.delete(project: project)
    }
    
    func details(of project: ProjectDTO) async throws -> Project {
        return try await repository.details(of: project)
    }
    
    func invite(user: User, to project: ProjectDTO) async throws {
        try await repository.invite(user: user, to: project)
    }
    
    func remove(user: User, from project: ProjectDTO) async throws {
        try await repository.remove(user: user, from: project)
        
    }
    
    init(repository: some RemoteProjectRepository) {
        self.repository = repository
    }
}
