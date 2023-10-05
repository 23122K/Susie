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
    @Published var estimation: Int32 = 0
    @Published var type: IssueType?
    @Published var priority: IssuePriority?
    
    @Published var types: Array<IssueType> = .init()
    @Published var priorities: Array<IssuePriority> = .init()
    
    private func fetchConfiguration() {
        Task {
            do {
                types = try await client.types()
                priorities = try await client.priorities()
                
                guard let type = types.first, let priority = priorities.first else {
                    throw AuthError.couldNotRefreshAuthObject
                }
                
                self.type = type
                self.priority = priority
                
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
                    let details: IssueDTO = IssueDTO(name: name, description: description, estimation: estimation, project: project, issueType: type,  issuePriority: priority)
                    let _ = try await client.create(issue: details)
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
