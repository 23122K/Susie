//
//  DefinitionOfDoneFormViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/12/2023.
//

import SwiftUI
import Factory

@MainActor
class DefinitionOfDoneFormViewModel: ObservableObject {
    let commitmentRuleInteractor: any CommitmentRuleInteractor
    
    let project: Project
    let doesExist: Bool
    
    @Published var rule: Rule
    @Published var shouldDismiss: Bool = false
    @Published var focus: Field?
    
    enum Field: Hashable {
        case definition
    }
    
    func saveButtonTapped() {
        doesExist ? updateCommitmentRuleSent() : createCommitmentRuleRequestSent()
        self.shouldDismiss = true
    }
    
    func createCommitmentRuleRequestSent(){
        Task { try await commitmentRuleInteractor.createCommitmentRule(rule: rule, for: project) }
    }
    
    func updateCommitmentRuleSent() {
        Task { try await commitmentRuleInteractor.updateCommitmentRule(rule: rule) }
    }
    
    func dismissButtonTapped() {
        self.shouldDismiss = true
    }
    
    init(container: Container = Container.shared, project: Project, rule: Rule? = nil, focus: Field? = .definition) {
        self.commitmentRuleInteractor = container.commitmentRuleInteracotr.resolve()
        
        self.project = project
        self.focus = focus
        
        switch rule {
        case let .some(rule):
            self.doesExist = true
            self._rule = Published(wrappedValue: rule)
        case .none:
            self.doesExist = false
            self.rule = Rule(id: .default, definition: .default)
        }
    }
}
