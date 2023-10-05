//
//  BoardsViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 28/09/2023.
//

import SwiftUI
import Factory

@MainActor
class BoardsViewModel: ObservableObject {
    var project: Project
    private var client: Client
    
    @Published var issues: Array<IssueGeneralDTO> = []
    @Published var statuses: Array<IssueStatus> = []
    
    func fetchIssues() {
        Task {
            do {
                self.issues = try await client.issues(project: project)
            } catch {
                print(error)
            }
        }
    }
    
    func fetchStatuses() {
        Task {
            do {
                self.statuses = try await client.statuses()
                print(statuses)
            } catch {
                print("FAILS")
                print(error)
            }
        }
    }
    
    init(container: Container = Container.shared, project: Project) {
        self.client = container.client()
        self.project = project
        
        fetchStatuses()
        fetchIssues()
    }
}
