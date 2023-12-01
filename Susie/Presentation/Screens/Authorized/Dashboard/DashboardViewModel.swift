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
    var destintation: Destination?
    
    let projectInteractor: any ProjectInteractor
    
    enum Destination {
        case invite
    }
    
    @Published var invitation: InviteRequest
    
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
    
    init(container: Container = Container.shared, project: Project, user: User, destination: Destination? = nil) {
        self.project = project
        self.user = user
        self.destintation = destination
        self.projectInteractor = container.projectInteractor.resolve()
        
        self.invitation = InviteRequest(project: project)
    }
}
