//
//  ProjectFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI

struct ProjectFormView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject private var vm: ProjectFormViewModel
    @FocusState private var focusedField: FocusedField?
    
    private enum FocusedField: Hashable {
        case name
        case description
        case goal
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Project name", text: $vm.project.name)
                .textFieldStyle(.susiePrimaryTextField)
                .focused($focusedField, equals: .name)
                .onSubmit { focusedField = .description }
            
            ToggableSection(title: "Description", isToggled: true) {
                TextField("Project description", text: $vm.project.description, axis: .vertical)
                    .lineLimit(4...)
                    .textFieldStyle(.susieSecondaryTextField)
                    .focused($focusedField, equals: .description)
                    .onSubmit{ focusedField = .goal }
                    .padding(.top)
            }
            
            ToggableSection(title: "Goal", isToggled: true) {
                TextField("Project goal", text: $vm.project.goal, axis: .vertical)
                    .lineLimit(4...)
                    .textFieldStyle(.susieSecondaryTextField)
                    .focused($focusedField, equals: .goal)
                    .padding(.top)
                    .onSubmit{ vm.saveProjectButtonTapped(); dismiss() }
            }
            
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            Button("Save") {
                vm.saveProjectButtonTapped()
                dismiss()
            }
        }
        .padding()
        .navigationTitle(vm.project.name.isEmpty ? "New project" : vm.project.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{ focusedField = .name }
    }
    
    init(project: Project? = nil) {
        self._vm = ObservedObject(initialValue: ProjectFormViewModel(project: project))
    }
}
