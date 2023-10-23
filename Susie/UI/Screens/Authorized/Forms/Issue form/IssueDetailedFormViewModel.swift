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
    
    
    @Published var error: NetworkError?
    
    @Published var issue: Issue {
        didSet { changeStatus() }
    }
    
    private func changeStatus() {
        guard issue.status != status else { return }
        
        Task {
            do {
                try await client.status(of: issue.toDTO(), to: issue.status)
            } catch { print(error) }
        }
    }
    
    func save() {
        Task {
            do {
                let _  = try await client.update(issue: issue.toDTO())
            } catch { print(error) }
        }
    }
    
    
    func assign() {
        Task {
            do {
                try await client.assign(to: issue.toDTO())
            } catch {
                print(error)
            }
        }
    }
    
    private func unassign() {
        Task {
            do {
                try await client.unassign(from: issue.toDTO())
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
