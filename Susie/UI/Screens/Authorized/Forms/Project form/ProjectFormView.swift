//
//  ProjectFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI

struct ProjectFormView: View {
    @Environment (\.dismiss) var dismiss
    @StateObject private var projectViewModel: ProjectViewModel
    @FocusState private var focusedField: FocusedField?
    
    private enum FocusedField: Hashable {
        case name
        case description
        case goal
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Project name", text: $projectViewModel.project.name)
                .textFieldStyle(.susiePrimaryTextField)
                .focused($focusedField, equals: .name)
                .onSubmit { focusedField = .description }
            
            ToggableSection(title: "Description", isToggled: true) {
                TextField("Project description", text: $projectViewModel.project.description, axis: .vertical)
                    .lineLimit(4...)
                    .textFieldStyle(.susieSecondaryTextField)
                    .focused($focusedField, equals: .description)
                    .onSubmit{ focusedField = .goal }
                    .padding(.top)
            }
            
            ToggableSection(title: "Goal", isToggled: true) {
                TextField("Project goal", text: $projectViewModel.project.goal, axis: .vertical)
                    .lineLimit(4...)
                    .textFieldStyle(.susieSecondaryTextField)
                    .focused($focusedField, equals: .goal)
                    .padding(.top)
                    .onSubmit{ projectViewModel.save(); dismiss() }
            }
            
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            Button("Save") {
                projectViewModel.save()
                dismiss()
            }
        }
        .padding()
        .navigationTitle(projectViewModel.project.name.isEmpty ? "New project" : projectViewModel.project.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{ focusedField = .name }
    }
    
    init(project: ProjectDTO? = nil) {
        _projectViewModel = StateObject(wrappedValue: ProjectViewModel(project: project))
    }
}
