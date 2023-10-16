//
//  HomeViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 07/10/2023.
//

import Foundation
import Factory

@MainActor
class HomeViewModel: ObservableObject {
    private(set) var user: User?
    
    private var client: Client
    private var project: ProjectDTO
    
    
    init(project: ProjectDTO, container: Container = Container.shared) {
        self.client = container.client()
        self.user = client.user
        self.project = project
    }
}

