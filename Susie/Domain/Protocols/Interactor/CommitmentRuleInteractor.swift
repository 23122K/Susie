//
//  CommitmentRuleInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/12/2023.
//

import Foundation

protocol CommitmentRuleInteractor {
    var repository: any RemoteCommitmentRuleRepository { get }
    
    func fetchAllComminmentRules(for project: Project) async throws -> Array<Rule>
    func createCommitmentRule(rule: Rule, for project: Project) async throws
    func updateCommitmentRule(rule: Rule) async throws
    func deleteCommitmentRule(rule: Rule, for project: Project) async throws    
}
