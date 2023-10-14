//
//  BoardViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 28/09/2023.
//

import SwiftUI
import Factory

@MainActor
class BoardViewModel: ObservableObject {
    private var client: Client
    @Published var issue: IssueGeneralDTO?
    
    init(container: Container = Container.shared) {
        self.client = container.client()
    }
}
