//
//  SprintFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/10/2023.
//

import SwiftUI

struct SprintFormView: View {
    @Environment (\.dismiss) private var dismiss
    @ObservedObject private var vm: SprintFromViewModel
    @FocusState private var focus: SprintFromViewModel.Field?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("\(.localized.sprintTitle)", text: $vm.sprint.name)
                .padding(.horizontal)
                .focused($focus, equals: .name)
                .onSubmit { vm.onSubmitOf(field: .name) }
                .textFieldStyle(.susiePrimaryTextField)
            
            TextField("\(.localized.sprintGoal)", text: $vm.sprint.goal)
                .padding(.horizontal)
                .focused($focus, equals: .goal)
                .onSubmit { vm.onSubmitOf(field: .goal) }
                .textFieldStyle(.susieSecondaryTextField)
            
            Toggle("\(.localized.startDate)", isOn: $vm.shouldHaveStartDate)
                .padding(.horizontal)
                .tint(.susieBluePriamry)
            
            DatePicker("\(.localized.startDate)", selection: $vm.startDate)
                .padding(.horizontal)
                .disabled(!vm.shouldHaveStartDate)
                .opacity(vm.shouldHaveStartDate ? 1 : 0)
                .datePickerStyle(.graphical)
                .animation(.spring, value: vm.shouldHaveStartDate)
        }
        .toolbar {
            Button("\(.localized.save)") { vm.saveSprintButtonTapped() }
        }
        .bind($vm.focus, to: $focus)
        .padding(.vertical)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(vm.sprint.name.isEmpty ? "\(LocalizedStringResource.localized.newSprint)" : vm.sprint.name)
        .onChange(of: vm.shouldDismiss) { shouldDismiss in if shouldDismiss { dismiss() } }
    }
    
    init(sprint: Sprint? = nil, project: Project) {
        self._vm = ObservedObject(initialValue: SprintFromViewModel(sprint: sprint, project: project))
    }
}
