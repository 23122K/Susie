//
//  RootViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import Foundation
import Factory

class RootViewModel: ObservableObject {
    private(set) var client: Client
    @Published private var hasChanged: Bool = false
    
    init() {
        self.client = Container.shared.client()
        
        client.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .assign(to: &$hasChanged)
    }
}
