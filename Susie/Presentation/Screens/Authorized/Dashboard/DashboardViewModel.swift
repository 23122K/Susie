//
//  DashboardViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 07/10/2023.
//

import Factory
import Foundation

@MainActor
class DashboardViewModel: ObservableObject {
    let project: Project
    let user: User
    
    let projectInteractor: RealProjectInteractor
    
    @Published var invitation: InviteRequest
    
    func inviteButtonTapped() {
        Task {
            try await projectInteractor.sendInvitation(invitation: invitation)
            self.invitation = .init()
        }
    }
    
    func fetchProjectDetails() {
        Task { try await projectInteractor.details(of: project.toDTO()) }
    }
    
    init(container: Container = Container.shared, project: Project, user: User) {
        self.project = project
        self.user = user
        self.projectInteractor = container.projectInteractor.resolve()
        
        self.invitation = InviteRequest(project: project)
    }
}
