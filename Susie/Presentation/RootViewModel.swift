//
//  RootViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 09/09/2023.
//

import SwiftUI
import Factory

@MainActor
class RootViewModel: ObservableObject {
    private var client: Client
    
    @Published var isAuthenticted: Bool = false
    @Published var scope: UserScope = .none
    
    init(container: Container = Container.shared) {
        self.client = container.client()
        
        client.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .assign(to: &$isAuthenticted)
        
        client.$scope
            .receive(on: DispatchQueue.main)
            .assign(to: &$scope)
    }
}

