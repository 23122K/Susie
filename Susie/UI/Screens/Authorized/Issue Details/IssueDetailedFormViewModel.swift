//
//  IssueDetailedFormViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 19/10/2023.
//

import Factory
import Foundation

@MainActor
class IssueDetailedFormViewModel: ObservableObject {
    private var client: Client
    private var status: IssueStatus
    @Published var issue: Issue
    
    func save() {
        Task {
            do {
                let _  = try await client.update(issue: issue.toDTO())
                if status != issue.status {
                    let _ = try await client.status(of: issue.toDTO(), to: issue.status)
                }
            } catch {
                print(error)
            }
        }
    }
    
    init(issue: Issue, container: Container = Container.shared) {
        self.client = container.client()
        self.status = issue.status
        _issue = Published(initialValue: issue)
    }
}
