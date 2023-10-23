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
    private var client: Client
    
    private(set) var project: ProjectDTO
    private(set) var user: User?
    
    @Published var invitation: InviteRequest
    @Published var projectDetials: LoadingState<Project> = .idle
    
    func invite() {
        Task {
            do {
                try await client.invite(invitation: invitation)
                self.invitation.email = ""
            } catch {
                print(error)
            }
        }
    }
    
    func fetch() {
        projectDetials = .idle
        Task {
            do {
                projectDetials = .loading
                let project = try await client.details(project: project)
                projectDetials = .loaded(project)
            } catch {
                projectDetials = .failed(error)
            }
        }
    }
    
    
    
    init(project: ProjectDTO, container: Container = Container.shared) {
        self.client = container.client()
        self.user = client.user
        self.project = project
        self.invitation = InviteRequest(project: project)
    }
}
