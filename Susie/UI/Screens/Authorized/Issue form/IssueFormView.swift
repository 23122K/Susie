//
//  IssueFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 28/09/2023.
//

import SwiftUI

struct IssueFormView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject private var vm: IssueFormViewModel
    @FocusState private var focusedField: FocusedField?
    
    private enum FocusedField: Hashable {
        case title
        case description
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Issue title", text: $vm.name)
                .textFieldStyle(.susiePrimaryTextField)
                .focused($focusedField, equals: .title)
                .onSubmit { focusedField = .description }
            
            TextField("Description", text: $vm.description, axis: .vertical)
                .lineLimit(4...)
                .textFieldStyle(.susieSecondaryTextField)
                .focused($focusedField, equals: .description)
                .onSubmit { focusedField = .description }
            
            HStack {
                
                Picker("Estimation", selection: $vm.estimation) {
                    ForEach(0...10, id: \.self) { number in
                        Text("\(number)").tag(Int32(number))
                    }
                }
                .pickerStyle(.menu)
                
                Picker("Issue type", selection: $vm.type, content: {
                    ForEach(IssueType.allCases, id: \.rawValue) { type in
                        Text("\(type.description)").tag(type)
                    }
                })
                .pickerStyle(.menu)
                
                Picker("Issue priority", selection: $vm.priority) {
                    ForEach(IssuePriority.allCases, id: \.rawValue) { priority in
                        Text(priority.description).tag(priority)
                    }
                }
                .pickerStyle(.menu)
            }
        }
        .padding()
        .navigationTitle(vm.name)
        .toolbar{
            Button("Save") {
                vm.create()
                dismiss()
            }
        }
        .onAppear{ focusedField = .title }
    }
    
    init(project: Project) {
        _vm = StateObject(wrappedValue: IssueFormViewModel(project: project))
    }
}
