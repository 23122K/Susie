//
//  RealCommitmentRuleInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/12/2023.
//

import Foundation

class RealCommitmentRuleInteractor: CommitmentRuleInteractor {
    var repository: RemoteCommitmentRuleRepository
    
    func fetchAllComminmentRules(for project: Project) async throws -> Array<Rule> {
        return try await repository.fetchAllComminmentRules(for: project)
    }
    
    func createCommitmentRule(rule: Rule, for project: Project) async throws {
        try await repository.createCommitmentRule(rule: rule, for: project)
    }
    
    func updateCommitmentRule(rule: Rule) async throws {
        try await repository.updateCommitmentRule(rule: rule)
    }
    
    func deleteCommitmentRule(rule: Rule, for project: Project) async throws {
        try await repository.deleteCommitmentRule(rule: rule, for: project)
    }
    
    init(repository: some RemoteCommitmentRuleRepository) {
        self.repository = repository
    }
}
