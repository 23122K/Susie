//
//  RealCommitmentRuleRemoteRepository.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/12/2023.
//

import Foundation

class RealCommitmentRuleRemoteRepository: RemoteCommitmentRuleRepository, ProtectedRepository {
    var session: URLSession
    var authenticationInterceptor: AuthenticationInterceptor
    
    func fetchAllComminmentRules(for project: Project) async throws -> Array<Rule> {
        let endpoint = Endpoints.CommitmentRuleEndpoint.fetch(project: project)
        print(endpoint.url)
        let rules = try await data(for: endpoint.request, interceptor: authenticationInterceptor).decode([Rule].self)
        print("Rules \(rules)")
        return rules
    }
    
    func createCommitmentRule(rule: Rule, for project: Project) async throws {
        let endpoint = Endpoints.CommitmentRuleEndpoint.create(rule: rule, project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func updateCommitmentRule(rule: Rule) async throws {
        let endpoint = Endpoints.CommitmentRuleEndpoint.update(rule: rule)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    func deleteCommitmentRule(rule: Rule, for project: Project) async throws{
        let endpoint = Endpoints.CommitmentRuleEndpoint.delete(rule: rule, project: project)
        return try await data(for: endpoint.request, interceptor: authenticationInterceptor)
    }
    
    init(session: URLSession = URLSession.shared, authenticationInterceptor: some AuthenticationInterceptor) {
        self.session = session
        self.authenticationInterceptor = authenticationInterceptor
    }
    
}
