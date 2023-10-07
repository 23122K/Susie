//
//  DashboardViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 07/10/2023.
//

import Factory
import Foundation

@MainActor
class DashboardViewModel: ObservableObject {
    private(set) var user: User?
    
    private var client: Client
    private var project: Project
    
    init(project: Project, container: Container = Container.shared) {
        self.client = container.client()
        self.user = client.user
        self.project = project
    }
}
