//
//  HomeView.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/07/2023.
//

import SwiftUI
import Factory

struct HomeView: View {
    @ObservedObject var vm: HomeViewModel

    var body: some View {
        NavigationStack {
            ScreenHeader(user: vm.user, title: .localized.home) {
               Menu(content: {
                   Button("\(.localized.createSprint)") {}
                   Button("\(.localized.createIssue)") {}
               }, label: {
                   Image(systemName: "ellipsis")
                       .scaleEffect(1.1)
               })
            }
            
            AsyncContentView(state: $vm.issues) { issues in
                BoardView(issues: issues)
            }
        
            Spacer()
        }
        .task { await vm.onAppear() }
        .refreshable{ await vm.onAppear() }
    }
    
    init(project: Project, user: User) { self._vm = ObservedObject(initialValue: HomeViewModel(project: project, user: user)) }
}
