//
//  IssueFormViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 28/09/2023.
//

import Foundation
import Factory

@MainActor
class IssueFormViewModel: ObservableObject {
    private var project: Project
    private var client: Client
    
    @Published var name: String = .init()
    @Published var description: String = .init()
    @Published var estimation: Int32 = 1
    @Published var type: IssueType?
    @Published var priority: IssuePriority?
    
    @Published var types: Array<IssueType> = .init()
    @Published var priorities: Array<IssuePriority> = .init()
    
    private func fetchConfiguration() {
        Task {
            do {
                types = try await client.fetchIssueTypesDictionary()
                
                priorities = try await client.fetchIssuePriorityDictionary()
            } catch {
                print(#function)
                print("error")
            }
        }
    }
    
    func create() {
        Task {
            do {
                if let type, let priority {
                    let details: IssueDTO = IssueDTO(name: name, description: description, estimation: estimation, project: project, issueType: type, issuePriority: priority)
                    print(details)
                    let _ = try await client.createIssue(details)
                }
            } catch {
                print(#function)
            }
        }
    }
    
    init(container: Container = Container.shared, project: Project) {
        self.client = container.client()
        self.project = project
        
        fetchConfiguration()
    }
}
