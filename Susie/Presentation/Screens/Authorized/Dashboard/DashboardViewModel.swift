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
    
    let projectInteractor: any ProjectInteractor
    
    @Published var destintation: Destination?
    @Published var invitation: InviteRequest
    
    enum Destination {
        case invite
    }
    
    func inviteButtonTapped() {
        Task {
            try await projectInteractor.sendInvitation(invitation: invitation)
            self.invitation = .init()
        }
    }
    
    func deleteProjectButtonTapped() {
        Task { try await projectInteractor.delete(project: project.toDTO()) }
    }
    
    func fetchProjectDetails() {
        Task { try await projectInteractor.details(of: project.toDTO()) }
    }
    
    init(
        container: Container = Container.shared,
        project: Project,
        user: User,
        destination: Destination? = .none
    ) {
        self.project = project
        self.user = user
        self.destintation = destination
        self.projectInteractor = container.projectInteractor.resolve()
        
        self.invitation = InviteRequest(project: project)
    }
}
