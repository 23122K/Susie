//
//  RealSprintInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 25/11/2023.
//

import Foundation

class RealSprintInteractor: SprintInteractor {
    var repository: RemoteSprintRepository
    
    func update(sprint: Sprint) async throws -> Sprint{
        return try await repository.update(sprint: sprint)
    }
    
    func create(sprint: Sprint) async throws -> Sprint {
        return try await repository.create(sprint: sprint)
    }
    
    func delete(sprint: Sprint) async throws {
        try await repository.delete(sprint: sprint)
    }
    
    func assignIssueToSprint(issue: IssueGeneralDTO, sprint: Sprint) async throws {
        try await repository.assignIssueToSprint(issue: issue, sprint: sprint)
    }
    
    func removeIssueFromSprint(issue: IssueGeneralDTO, sprint: Sprint) async throws {
        try await repository.removeIssueFromSprint(issue: issue, sprint: sprint)
    }
    
    func startSprint(sprint: Sprint) async throws {
        try await repository.startSprint(sprint: sprint)
    }
    
    func stopSprint(project: ProjectDTO) async throws {
        try await repository.stopSprint(project: project)
    }
    
    func fetchInactiveSprints(project: ProjectDTO) async throws -> Array<Sprint> {
        return try await repository.fetchInactiveSprints(project: project)
    }
    
    func fetchActiveSprint(project: ProjectDTO) async throws -> Sprint? {
        return try await repository.fetchActiveSprint(project: project)
    }
    
    init(repository: some RemoteSprintRepository) {
        self.repository = repository
    }
        
}
