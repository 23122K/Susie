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
    var issue: IssueGeneralDTO
    
    var commentInteractor: RealCommentInteractor
    var issueInteractor: RealIssueInteractor
    
    @Published var commentToEdit: Comment?
    @Published var comment: CommentDTO
    @Published var issueDetails: Loadable<Issue> = .idle
    
    func postCommentButtonTapped() {
        Task {
            do { try await commentInteractor.create(comment: comment) }
            catch { print(error) }
        }
    }
    
    func editCommentButtonTapped(comment: Comment) {
        self.comment.body = comment.body
    }
    
    func deleteCommentButtonTapped(comment: Comment) {
        Task {
            do { try await commentInteractor.delete(comment: comment) }
            catch { print(error) }
        }
    }
    
    func onAppear() {
        Task(priority: .high, operation: {
            do {
                try await Task.sleep(nanoseconds: 500_000_000)
                issueDetails = .loading
                let issue = try await issueInteractor.details(issue)
                issueDetails = .loaded(issue)
            } catch {
                issueDetails = .failed(error)
            }
        })
    }
    
    init(container: Container = Container.shared, issue: IssueGeneralDTO) {
        self.commentInteractor = container.commentInteractor.resolve()
        self.issueInteractor = container.issueInteractor.resolve()
        
        self.issue = issue
        self.comment = CommentDTO(issue: issue)
    }
}
