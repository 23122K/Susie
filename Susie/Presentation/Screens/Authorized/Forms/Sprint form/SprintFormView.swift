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
            TextField("Sprint name", text: $vm.sprint.name)
                .padding(.horizontal)
                .focused($focus, equals: .name)
//                .onSubmit { $focus = SprintFromViewModel.Field.goal }
                .textFieldStyle(.susiePrimaryTextField)
            
            TextField("Goal", text: $vm.sprint.goal)
                .padding(.horizontal)
//                .focused($focus, equals: .goal)
                .textFieldStyle(.susieSecondaryTextField)
            
            Toggle("Start date", isOn: $vm.shouldHaveStartDate)
                .padding(.horizontal)
                .tint(.susieBluePriamry)
            
            DatePicker("Start date", selection: $vm.startDate)
                .padding(.horizontal)
                .disabled(!vm.shouldHaveStartDate)
                .opacity(vm.shouldHaveStartDate ? 1 : 0)
                .datePickerStyle(.graphical)
                .animation(.spring, value: vm.shouldHaveStartDate)
        }
        .toolbar {
            Button("Save") {
                vm.saveSprintButtonTapped()
                dismiss()
            }
        }
        .padding(.vertical)
        .onAppear{ focus = .name }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(vm.sprint.name.isEmpty ? "New sprint" : vm.sprint.name)
    }
    
    init(sprint: Sprint? = nil, project: Project) {
        self._vm = ObservedObject(initialValue: SprintFromViewModel(sprint: sprint, project: project))
    }
}
