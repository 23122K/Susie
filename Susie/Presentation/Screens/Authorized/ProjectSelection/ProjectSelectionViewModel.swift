//
//  ProjectViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI
import Factory

@MainActor
class ProjectSelectionViewModel: ObservableObject {
    let user: User
    let projectInteractor: any ProjectInteractor
    
    @Published var projects: Loadable<[ProjectDTO]>
    
    func selectProjectButtonTapped(project: ProjectDTO) {
        Task { try await projectInteractor.details(of: project) }
    }
    
    func onAppear() {
        Task {
            do {
                self.projects = .loading
                try await Task.sleep(nanoseconds: 300_000_000)
                let projects = try await projectInteractor.fetch()
                self.projects = .loaded(projects)
            } catch {
                self.projects = .failed(error)
            }
        }
    }
    
    func delete(project: ProjectDTO) {
        Task {
            try await projectInteractor.delete(project: project)
            self.onAppear()
        }
    }
    
    init(
        container: Container = Container.shared,
        user: User,
        projects: Loadable<[ProjectDTO]> = .idle
    ) {
        self.projectInteractor = container.projectInteractor.resolve()
        
        self.user = user
        self.projects = projects
    }
}
