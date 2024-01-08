//
//  SprintInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 25/11/2023.
//

import Foundation

protocol SprintInteractor {
    var repository: any RemoteSprintRepository { get }
    
    func update(sprint: Sprint) async throws -> Sprint
    func create(sprint: Sprint) async throws -> Sprint
    func delete(sprint: Sprint) async throws
    func assignIssueToSprint(issue: IssueGeneralDTO, sprint: Sprint) async throws
    func removeIssueFromSprint(issue: IssueGeneralDTO, sprint: Sprint) async throws
    func startSprint(sprint: Sprint) async throws
    func stopSprint(project: Project) async throws
    func fetchInactiveSprints(project: Project) async throws -> Array<Sprint>
    func fetchActiveSprint(project: Project) async throws -> Sprint? 
}
