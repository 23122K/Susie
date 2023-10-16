//
//  IssueDetailsViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import Foundation
import SwiftUI
import Factory

@MainActor
class IssueDetailsViewModel: ObservableObject {
    private var client: Client
    private var issue: IssueGeneralDTO
    @Published var detailedIssue: Issue!
    @Published var state: LoadingState<Issue> = .idle
    
    func fetch() {
        Task(priority: .high, operation: {
            do {
                self.state = .loading
                let issue = try await self.client.details(issue: issue)
                detailedIssue = issue
                self.state = .loaded(issue)
            } catch {
                self.state = .failed(error)
            }
        })
    }
    
    
    
    init(issue: IssueGeneralDTO, container: Container = Container.shared) {
        self.client = container.client()
        self.issue = issue
    }
}
