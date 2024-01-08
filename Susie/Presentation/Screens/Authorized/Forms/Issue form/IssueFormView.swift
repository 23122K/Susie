//
//  IssueFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 28/09/2023.
//

import SwiftUI
import PartialSheet

struct IssueFormView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject private var vm: IssueFormViewModel
    @FocusState private var focus: IssueFormViewModel.Field?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("\(.localized.issueTitle)", text: $vm.issue.name)
                .textFieldStyle(.susiePrimaryTextField)
                .focused($focus, equals: .title)
                .onSubmit { vm.onSumbitOf(field: .title) }
            
            
            ToggableSection(title: .localized.description, isToggled: true) {
                TextField("\(.localized.description)", text: $vm.issue.description, axis: .vertical)
                    .lineLimit(2...)
                    .textFieldStyle(.susieSecondaryTextField)
                    .focused($focus, equals: .description)
                    .onSubmit { vm.onSumbitOf(field: .description) }
            }
            
            ToggableSection(title: .localized.details, isToggled: true) {
                ToggableSectionRowView(title: .localized.issuePriority) {
                    Button(action: { vm.destinationButtonTapped(for: .priority) }, label: {
                        TagView(text: vm.issue.priority.description, color: vm.issue.priority.color)
                    })
                }
                ToggableSectionRowView(title: .localized.issueTitle) {
                    Button(action: { vm.destinationButtonTapped(for: .type) }, label: {
                        TagView(text: vm.issue.type.description, color: vm.issue.type.color)
                    })
                }
                ToggableSectionRowView(title: .localized.issueEstimation, divider: false) {
                    HStack {
                        Text("\(vm.issue.estimation.description)")
                        Slider(value: .convert(from: $vm.issue.estimation), in: 1...20, step: 1)
                            .tint(Color.susieBlueSecondary)
                    }
                }
                
            }
        }
        .bind($vm.focus, to: $focus)
        .sheet(item: $vm.destination) { destination in
            switch destination {
            case .priority:
                TagPickerView(enum: $vm.issue.priority, onSelect: {
                    vm.dismissDestintationButtonTapped()
                })
            case .type:
                TagPickerView(enum: $vm.issue.type, onSelect: {
                    vm.dismissDestintationButtonTapped()
                })
            }
        }
        .padding()
        .navigationTitle(vm.issue.name)
        .toolbar(.hidden, for: .tabBar)
        .toolbar{
            Button("\(.localized.save)") { vm.createIssueButtonTapped() }
        }
        .onChange(of: vm.dismiss) { _ in dismiss() }
    }
    
    init(project: Project) {
        _vm = ObservedObject(initialValue: IssueFormViewModel(project: project))
    }
}
