//
//  IssueDetailedFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 19/10/2023.
//

import SwiftUI
import PartialSheet

struct IssueDetailedFormView: View {
    @ObservedObject private var vm: IssueDetailedFormViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("\(.localized.issueTitle)", text: $vm.issue.name)
                .textFieldStyle(.susiePrimaryTextField)
            
            Button(action: {
                vm.destinationButtonTapped(for: .status)
            }, label: {
                HStack {
                    Spacer()
                    Text(verbatim: vm.issue.status.description)
                    Spacer()
                }
                .foregroundStyle(Color.susieWhitePrimary)
                .padding()
                .font(.title3)
                .fontWeight(.semibold)
                .background(Color.susieBluePriamry)
                .cornerRadius(9)
                .transition(.move(edge: .trailing))
            })
            
            ToggableSection(title: .localized.description, isToggled: true) {
                TextField("\(.localized.description)", text: $vm.issue.description, axis: .vertical)
                    .lineLimit(2...)
                    .textFieldStyle(.susieSecondaryTextField)
            }
            
            ToggableSection(title: .localized.details, isToggled: false) {
                ToggableSectionRowView(title: .localized.issuePriority) {
                    Button(action: { vm.destinationButtonTapped(for: .priority) }, label: {
                        TagView(text: vm.issue.priority.description, color: vm.issue.priority.color)
                    })
                }
                
                ToggableSectionRowView(title: .localized.issueType) {
                    Button(action: { vm.destinationButtonTapped(for: .type) }, label: {
                        TagView(text: vm.issue.type.description, color: vm.issue.type.color)
                    })
                }
                
                ToggableSectionRowView(title: .localized.issueEstimation) {
                    HStack {
                        Text(vm.issue.estimation.description)
                        Slider(value: .convert(from: $vm.issue.estimation), in: 1...20, step: 1)
                            .tint(Color.susieBlueSecondary)
                    }
                }
                
                ToggableSectionRowView(title: .localized.asignee, divider: false) {
                    Button(action: {
                        vm.assignToIssueButtonTapped()
                    }, label: {
                        HStack{
                            InitialsView(user: vm.issue.assignee, size: 30)
                            Text(vm.issue.assignee?.fullName ?? "\(LocalizedStringResource.localized.unassigned)")
                        }
                    })
                }
            }
            
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("\(.localized.save)") {
                    vm.updateIssueDetailsButtonTapped()
                }
            })
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(vm.issue.name)
        .padding()
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
            case .status:
                TagPickerView(enum: $vm.issue.status, onSelect: {
                    vm.dismissDestintationButtonTapped()
                })
            }
        }
    }
    
    init(issue: Issue) {
        _vm = ObservedObject(initialValue: IssueDetailedFormViewModel(issue: issue))
    }
}
