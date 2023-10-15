//
//  SprintsViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/10/2023.
//

import SwiftUI
import Factory

@MainActor
class SprintsViewModel: ObservableObject, AsyncDataProvider {
    private var client: Client
    
    private(set) var project: Project
    private(set) var user: User?
    
    @Published var sprint: Sprint?
    @Published var issue: IssueGeneralDTO?
    
    @Published var state: LoadingState<[Sprint]> = .idle
    
    func fetch() {
        state = .idle
        
        Task(priority: .high) {
            do {
                state = .loading
                print(#function)
                let sprints = try await client.sprints(project: project.toDTO())
                print(sprints)
                state = .loaded(sprints)
            } catch {
                state = .failed(error)
            }
        }
    }
    
    
    func assign(to sprint: Sprint) -> Bool {
        defer { issue = nil }
        
        guard let issue else {
            return false
        }
        
        Task {
            do {
                try await client.assign(issue: issue, to: sprint)
            } catch {
                state = .failed(error)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.fetch()
            }
            
        }
        
        return true
        
    }
    
    init(project: Project, container: Container = Container.shared) {
        self.client = container.client()
        self.user = client.user
        self.project = project
    }
}
