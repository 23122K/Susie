//
//  IssueFormViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 28/09/2023.
//

import Foundation
import Factory

@MainActor
class IssueFormViewModel: ObservableObject {
    let issueInteractor: RealIssueInteractor
    
    @Published var issue: IssueDTO
    
    func createIssueButtonTapped() {
        Task { try await issueInteractor.create(issue) }
    }
    
    init(container: Container = Container.shared, project: Project) {
        self.issueInteractor = container.issueInteractor.resolve()
        
        self.issue = IssueDTO(project: project)
    }
}
