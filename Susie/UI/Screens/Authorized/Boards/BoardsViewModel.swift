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
    private(set) var project: Project
    private(set) var user: User?
    private var client: Client
    private var sprint: Sprint?
    
    @Published var issues: Array<IssueGeneralDTO> = []
    @Published var statuses: IssueStatus = .toDo
    
    public func refresh() {
//        fetchSprint()()
        fetchIssue()
    }
    
    func fetchIssue() {
        Task {
            do {
                self.issues = try await client.issues(backlog: project.toDTO())
            } catch {
                print(error)
            }
        }
    }
    
    func fetchSprint() {
        Task { self.sprint = try await client.active(project: project.toDTO()) }
    }
    
//    func fetchStatuses() {
//        Task {
//            do {
//                self.statuses = try await client.statuses()
//                print(statuses)
//            } catch {
//                print("FAILS")
//                print(error)
//            }
//        }
//    }
    
    init(container: Container = Container.shared, project: Project) {
        self.client = container.client()
        self.user = client.user
        self.project = project
    }
}
