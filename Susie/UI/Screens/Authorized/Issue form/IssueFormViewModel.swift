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

    @Published var type: IssueType = .bug
    @Published var priority: IssuePriority = .low
    
    @Published var priorities: Array<IssuePriority> = .init()
    
    private func fetchConfiguration() {
        Task {
            do {
                priorities = try await client.priorities()
                
                guard let priority = priorities.first else {
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
                let details: IssueDTO = IssueDTO(name: name, description: description, estimation: estimation, project: project, type: type,  priority: priority)
                let _ = try await client.create(issue: details)
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
