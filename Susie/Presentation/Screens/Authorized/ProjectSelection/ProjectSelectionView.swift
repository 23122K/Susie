//
//  ProjectsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI
import SwipeActions

struct ProjectSelectionView: View {
    @ObservedObject private var vm: ProjectSelectionViewModel
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .lastTextBaseline) {
                ScreenHeader(user: vm.user, title: "\(LocalizedStringResource.localized.projects)", action: {
                    //TODO: Toogle sometinh
                }, content: {
                    NavigationLink(destination: {
                        ProjectFormView()
                    }, label: {
                        Image(systemName: "plus")
                            .scaleEffect(1.1)
                    })
                })
            }
            
            ScrollView {
                AsyncContentView(state: $vm.projects, { projects in
                    ForEach(projects) { project in
                        SwipeContent {
                            ProjectRowView(project: project)
                        } onDelete: {
                            vm.delete(project: project)
                        }
                        .onTapGesture { vm.selectProjectButtonTapped(project: project) }
                }
                }, placeholder: ProjectPlaceholderView())
            }
            .onAppear { vm.onAppear() }
            .refreshable { vm.onAppear() }
        }
    }
    
    init(user: User) { self._vm = ObservedObject(initialValue: ProjectSelectionViewModel(user: user)) }
}
