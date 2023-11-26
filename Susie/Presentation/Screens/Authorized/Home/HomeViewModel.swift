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
    
    let issueInteractor: RealIssueInteractor
    
    init(container: Container = Container.shared, project: Project, user: User) {
        self.project = project
        self.user = user
        self.issueInteractor = container.issueInteractor.resolve()
    }
}

