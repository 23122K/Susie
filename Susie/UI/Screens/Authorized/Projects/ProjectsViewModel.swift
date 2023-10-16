//
//  ProjectViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI
import Factory

@MainActor
class ProjectsViewModel: ObservableObject, AsyncDataProvider {
    private var client: Client
    
    @Published var project: ProjectDTO?
    @Published var user: User?
    
    @Published var state: LoadingState<[ProjectDTO]> = .idle
    
    func fetch() {
        state = .idle
        
        Task {
            do {
                state = .loading
                try await Task.sleep(nanoseconds: 300_000_000)
                let projects = try await client.projects()
                state = .loaded(projects)
            } catch {
                state = .failed(error)
            }
        }
    }
    
    func delete(project: ProjectDTO) {
        Task { 
            try await client.delete(project: project)
            self.fetch()
        }
    }
    
    func info() {
        Task { self.user = try await client.info() }
    }
    
    init(container: Container = Container.shared) {
        self.client = container.client()
        info() //TODO: Make Client class await for some data after it triggers IsAuthenticated
    }
}
