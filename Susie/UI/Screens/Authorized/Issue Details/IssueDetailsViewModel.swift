//
//  IssueDetailsViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import Foundation
import Factory

@MainActor
class IssueDetailsViewModel: ObservableObject, AsyncDataProvider {
    private var client: Client
    private var issue: IssueGeneralDTO
        
    @Published var state: LoadingState<Issue> = .idle
    
    func fetch() {
        Task(priority: .high, operation: {
            do {
                self.state = .loading
                let issue = try await client.details(issue: issue)
                self.state = .loaded(issue)
            } catch {
                self.state = .failed(error)
            }
        })
    }
    
    init(issue: IssueGeneralDTO, container: Container = Container.shared) throws {
        self.client = container.client()
        self.issue = issue
    }
}
