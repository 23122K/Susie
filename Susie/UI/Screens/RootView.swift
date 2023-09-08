//
//  ContentView.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/09/2023.
//

import SwiftUI
import Factory

struct RootView: View {
    @StateObject var vm: RootViewModel = RootViewModel()
    
    var body: some View {
        switch vm.client.isAuthenticated {
        case true:
            AuthenticatedUserView()
        case false:
            WelcomePageView()
        }
    }
}
