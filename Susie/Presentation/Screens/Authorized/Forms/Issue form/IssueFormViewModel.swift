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
    let issueInteractor: any IssueInteractor
    
    @Published var issue: IssueDTO
    @Published var focus: Field?
    @Published var shouldDismiss: Bool = .deafult
    
    enum Field: Hashable {
        case title
        case description
    }
    
    func createIssueButtonTapped() {
        Task {
            try await issueInteractor.create(issue)
            shouldDismiss.toggle()
        }
    }
    
    func onSumbitOf(field: Field) {
        switch field {
        case .title:
            focus = .description
        case .description:
            focus = .none
        }
    }
    
    
    init(container: Container = Container.shared, project: Project, focus: Field? = .title) {
        self.issueInteractor = container.issueInteractor.resolve()
        
        self.issue = IssueDTO(project: project)
        self.focus = focus
    }
}
