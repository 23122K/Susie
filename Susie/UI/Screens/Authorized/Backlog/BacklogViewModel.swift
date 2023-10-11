//
//  BacklogViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI
import Factory

@MainActor
class BacklogViewModel: ObservableObject {
    private(set) var project: Project
    private(set) var user: User?
    private var client: Client
    
    @Published var issues: Array<IssueGeneralDTO> = []
    @Published var issue: Issue?
    
    func details(of issue: IssueGeneralDTO) {
        Task { self.issue = try await client.details(issue: issue) }
    }
    
    func fetch() {
        Task { self.issues = try await client.issues(backlog: project.toDTO()) }
    }
    
    func delete(issue: IssueGeneralDTO) {
        Task { try await client.delete(issue: issue) }
    }
    
    init(project: Project, container: Container = Container.shared) {
        self.client = container.client()
        self.user = client.user
        self.project = project
        
        fetch()
    }
}
