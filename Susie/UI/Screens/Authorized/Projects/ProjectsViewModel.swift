//
//  ProjectViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI
import Factory

class ProjectViewModel: ObservableObject {
    @Published var client: Client
    
    init() {
        self.client = Container.shared.client()
    }
}
