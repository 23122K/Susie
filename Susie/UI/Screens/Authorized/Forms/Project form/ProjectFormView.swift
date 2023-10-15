//
//  ProjectFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI

struct ProjectFormView: View {
    @StateObject private var vm: ProjectViewModel
    @FocusState private var focusedField: FocusedField?
    
    private enum FocusedField: Hashable {
        case name
        case description
        case goal
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Project name", text: $vm.name)
                .textFieldStyle(.susiePrimaryTextField)
                .focused($focusedField, equals: .name)
                .onSubmit { focusedField = .description }
            
            TextField("Description", text: $vm.description, axis: .vertical)
                .lineLimit(4...)
                .textFieldStyle(.susieSecondaryTextField)
                .focused($focusedField, equals: .description)
                .onSubmit{ focusedField = .goal }
                .padding(.bottom)
            
            //TODO: Remove constant
//            TextField("Goal", text: $vm.goal ?? .constant("Change it"), axis: .vertical)
//                .lineLimit(2...)
//                .textFieldStyle(.susieSecondaryTextField)
//                .focused($focusedField, equals: .goal)
//                .onSubmit{ vm.save() }
//                .padding(.bottom)
            
            Button("Save") {
                vm.save()
            }
            .buttonStyle(.secondary)
        }
        .padding()
        .navigationTitle(vm.name.isEmpty ? "New project" : vm.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear{ focusedField = .name }
    }
    
    init(project: ProjectDTO? = nil) {
        _vm = StateObject(wrappedValue: ProjectViewModel(project: project))
    }
}
