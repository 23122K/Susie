//
//  ProjectViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI
import Factory

extension ProjectsView {
    
    @MainActor
    class ViewModel: ObservableObject {
        private(set) var appStore: AppStore
        private(set) var projectInteractor: RealProjectInteractor

        @Published var project: ProjectDTO?
        @Published var projects: Loadable<[ProjectDTO]> = .idle
        
        func fetch() {
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
                self.fetch()
            }
        }
        
        init(container: Container = Container.shared) {
            self.appStore = container.appStore.resolve()
            self.projectInteractor = container.projectInteractor.resolve()
        }
    }
}
