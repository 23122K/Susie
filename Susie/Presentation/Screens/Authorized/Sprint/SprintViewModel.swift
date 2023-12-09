//
//  SprintViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import Foundation
import Factory

@MainActor
class SprintViewModel: ObservableObject {
    let sprint: Sprint
    let project: Project
    
    let issueInteractor: any IssueInteractor
    let sprintInteractor: any SprintInteractor
    
    @Published var dismiss: Bool
    @Published var destination: Destination?
    @Published var issues: Loadable<[IssueGeneralDTO]>
    
    enum Destination: Identifiable, Hashable {
        var id: Self { self }
        
        case details(IssueGeneralDTO)
    }
    
    func onAppear() {
        Task {
            do {
                self.issues = .loading
                let issues = try await issueInteractor.fetchIssuesFromSprint(sprint)
                self.issues = .loaded(issues)
            } catch {
                self.issues = .failed(error)
            }
        }
    }
    
    func startSprintButtonTapped() {
        Task {
            do {
                try await sprintInteractor.startSprint(sprint: sprint)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func destinationButtonTapped(for destination: Destination) {
        self.destination = destination
    }
    
    func dismissButtonTapped() {
        self.dismiss.toggle()
    }
    
    func deleteSprintButtonTapped() {
        Task {
            do {
                try await sprintInteractor.delete(sprint: sprint)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    init(container: Container = Container.shared,
         sprint: Sprint,
         project: Project,
         issue: IssueGeneralDTO? = .none,
         issues: Loadable<[IssueGeneralDTO]> = .idle,
         destination: Destination? = .none,
         dismiss: Bool = .deafult
    ) {
        self.issueInteractor = container.issueInteractor.resolve()
        self.sprintInteractor = container.sprintInteractor.resolve()
        
        self.sprint = sprint
        self.project = project
        self.issues = issues
        self.issues = issues
        self.dismiss = dismiss
    }
}
