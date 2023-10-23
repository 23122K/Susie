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
    
    @Published var comment: CommentDTO
    @Published var issueDetails: LoadingState<Issue> = .idle
    
    func fetch() {
        Task(priority: .high, operation: {
            do {
                issueDetails = .loading
                let issue = try await self.client.details(issue: issue)
                issueDetails = .loaded(issue)
            } catch {
                issueDetails = .failed(error)
            }
        })
    }
    
    func post() {
        Task {
            do {
                try await client.post(comment: comment)
            } catch {
                print(error)
            }
        }
    }
    
    func delete(comment: Comment) {
        Task {
            do {
                try await client.delete(comment: comment)
            } catch {
                print(error)
            }
        }
    }
    
    
    
    init(issue: IssueGeneralDTO, container: Container = Container.shared) {
        self.client = container.client()
        self.issue = issue
        self.comment = CommentDTO(issue: issue, body: String())
    }
}
