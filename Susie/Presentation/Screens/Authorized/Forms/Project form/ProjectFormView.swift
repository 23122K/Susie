//
//  ProjectFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI

struct ProjectFormView: View {
    @Environment (\.dismiss) private var dismiss
    @ObservedObject private var vm: ProjectFormViewModel
    @FocusState private var focus: ProjectFormViewModel.Field?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Project name", text: $vm.project.name)
                .textFieldStyle(.susiePrimaryTextField)
                .focused($focus, equals: .name)
                .onSubmit { vm.onSumbitOf(field: .name) }
            
            ToggableSection(title: "Description", isToggled: true) {
                TextField("Project description", text: $vm.project.description, axis: .vertical)
                    .lineLimit(4...)
                    .textFieldStyle(.susieSecondaryTextField)
                    .focused($focus, equals: .description)
                    .onSubmit { vm.onSumbitOf(field: .description) }
                    .padding(.top)
            }
            
            ToggableSection(title: "Goal", isToggled: true) {
                TextField("Project goal", text: $vm.project.goal, axis: .vertical)
                    .lineLimit(4...)
                    .textFieldStyle(.susieSecondaryTextField)
                    .focused($focus, equals: .goal)
                    .onSubmit { vm.onSumbitOf(field: .goal) }
                    .padding(.top)
            }
            
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            Button("Save") {
                vm.saveProjectButtonTapped()
            }
        }
        .bind($vm.focus, to: $focus)
        .padding()
        .navigationTitle(vm.project.name.isEmpty ? "New project" : vm.project.name)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: vm.shouldDismiss) { shouldDismiss in if shouldDismiss { dismiss() } }
    }
    
    init(project: Project? = nil) {
        self._vm = ObservedObject(initialValue: ProjectFormViewModel(project: project))
    }
}
