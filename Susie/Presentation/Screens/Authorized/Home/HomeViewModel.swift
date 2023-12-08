//
//  HomeViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 07/10/2023.
//

import Foundation
import Factory

@MainActor
class HomeViewModel: ObservableObject {
    let user: User
    let project: Project
    
    let issueInteractor: any IssueInteractor
    
    @Published var issues: Loadable<[IssueGeneralDTO]> = .idle
    
    func onAppear() async {
        do {
            self.issues = .loading
            let issues = try await issueInteractor.fetchIssuesAssignedToSignedUser()
            print(issues)
            self.issues = .loaded(issues)
        } catch {
            self.issues = .failed(error)
        }
    }
    
    init(container: Container = Container.shared, project: Project, user: User) {
        self.project = project
        self.user = user
        self.issueInteractor = container.issueInteractor.resolve()
    }
}

