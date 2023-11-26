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
            ScreenHeader(user: vm.user, screenTitle: "Home") {
               Menu(content: {
                   Button("Create sprint") {}
                   Button("Create issue") {}
               }, label: {
                   Image(systemName: "ellipsis")
                       .scaleEffect(1.1)
               })
           }
            
            Spacer()
        }
    }
    
    init(project: Project, user: User) { self._vm = ObservedObject(initialValue: HomeViewModel(project: project, user: user)) }
}
