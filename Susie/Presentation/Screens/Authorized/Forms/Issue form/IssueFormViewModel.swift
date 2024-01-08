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
    @Published var dismiss: Bool
    @Published var destination: Destination?
    
    enum Field: Hashable {
        case title
        case description
    }
    
    enum Destination: Identifiable, Hashable {
        var id: Self { return self }
        
        case priority
        case type
    }
    
    func createIssueButtonTapped() {
        Task {
            try await issueInteractor.create(issue)
            dismiss.toggle()
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
    
    func destinationButtonTapped(for destination: Destination) {
        self.destination = destination
    }
    
    func dismissDestintationButtonTapped() {
        self.destination = .none
    }
    
    init(container: Container = Container.shared, project: Project, focus: Field? = .title, dismiss: Bool = .deafult, destination: Destination? = nil) {
        self.issueInteractor = container.issueInteractor.resolve()
        
        self.issue = IssueDTO(project: project)
        self.focus = focus
        self.dismiss = dismiss
        self.destination = destination
    }
}
