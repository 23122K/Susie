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
    private var client: Client
    @Published var issue: IssueDTO
    
    func create() {
        Task {
            do {
                let _ = try await client.create(issue: issue)
            } catch {
                print(#function)
            }
        }
    }
    
    init(project: ProjectDTO, container: Container = Container.shared) {
        self.client = container.client()
        self.issue = IssueDTO(project: project)
    }
}
