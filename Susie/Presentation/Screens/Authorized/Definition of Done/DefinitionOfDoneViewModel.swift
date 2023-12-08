//
//  DefinitionOfDoneViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 04/12/2023.
//

import Foundation
import Factory

@MainActor
class DefinitionOfDoneViewModel: ObservableObject {
    let commitmentRuleInteractor: any CommitmentRuleInteractor
    
    let project: Project
    
    @Published var destination: Destination?
    @Published var rules: Loadable<[Rule]> = .idle
    
    enum Destination: Identifiable, Hashable {
        var id: Self { return self }
        
        case create
        case edit(Rule)
    }
    
    func deleteButtonTapped(on rule: Rule) {
        Task {
            do {
                try await commitmentRuleInteractor.deleteCommitmentRule(rule: rule, for: project)
            } catch {
                print(error)
            }
        }
    }
    
    func onAppear() async {
        do {
            self.rules = .loading
            let rules = try await commitmentRuleInteractor.fetchAllComminmentRules(for: project)
            self.rules = .loaded(rules)
        } catch { self.rules = .failed(error) }
    }
    
    func createRuleButtonTapped() {
        self.destination = .create
    }
    
    func selectRuleButtonTapped(on rule: Rule) {
        self.destination = .edit(rule)
    }
    
    init(container: Container = Container.shared, project: Project) {
        self.commitmentRuleInteractor = container.commitmentRuleInteracotr.resolve()
        self.destination = .none
        self.project = project
    }
}
