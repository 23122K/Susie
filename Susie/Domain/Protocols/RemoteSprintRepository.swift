//
//  RemoteSprintRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol RemoteSprintRepository: RemoteRepository {
    func update(sprint: Sprint) async throws -> Sprint
    func create(sprint: Sprint) async throws -> Sprint
    func delete(sprint: Sprint) async throws
    func assignIssueToSprint(issue: IssueGeneralDTO, sprint: Sprint) async throws
    func removeIssueFromSprint(issue: IssueGeneralDTO, sprint: Sprint) async throws
    func startSprint(sprint: Sprint) async throws
    func stopSprint(project: ProjectDTO) async throws
    func fetchInactiveSprints(project: ProjectDTO) async throws -> Array<Sprint>
    func fetchActiveSprint(project: ProjectDTO) async throws -> Sprint?
}
