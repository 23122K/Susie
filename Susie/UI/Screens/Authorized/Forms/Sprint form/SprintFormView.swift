//
//  SprintFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/10/2023.
//

import SwiftUI

struct SprintFormView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject private var sprintViewModel: SprintFromViewModel
    @FocusState private var focusedField: FocusedField?
    
    private enum FocusedField: Hashable {
        case name
        case goal
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Sprint name", text: $sprintViewModel.sprint.name)
                .padding(.horizontal)
                .focused($focusedField, equals: .name)
                .onSubmit { focusedField = .goal}
                .textFieldStyle(.susiePrimaryTextField)
            
            TextField("Goal", text: $sprintViewModel.sprint.goal)
                .padding(.horizontal)
                .focused($focusedField, equals: .goal)
                .textFieldStyle(.susieSecondaryTextField)
            
            Toggle("Start date", isOn: $sprintViewModel.shouldHaveStartDate)
                .padding(.horizontal)
                .tint(.susieBluePriamry)
            
            DatePicker("Start date", selection: $sprintViewModel.startDate)
                .padding(.horizontal)
                .disabled(!sprintViewModel.shouldHaveStartDate)
                .opacity(sprintViewModel.shouldHaveStartDate ? 1 : 0)
                .datePickerStyle(.graphical)
                .animation(.spring, value: sprintViewModel.shouldHaveStartDate)
        }
        .toolbar {
            Button("Save") {
                sprintViewModel.save()
                dismiss()
            }
        }
        .padding(.vertical)
        .onAppear{ focusedField = .name }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(sprintViewModel.sprint.name.isEmpty ? "New sprint" : sprintViewModel.sprint.name)
    }
    
    init(sprint: Sprint? = nil, project: ProjectDTO) {
        _sprintViewModel = StateObject(wrappedValue: SprintFromViewModel(sprint: sprint, project: project))
    }
}
