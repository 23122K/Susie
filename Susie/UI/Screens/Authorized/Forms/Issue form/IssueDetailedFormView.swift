//
//  IssueDetailedFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 19/10/2023.
//

import SwiftUI
import PartialSheet

struct IssueDetailedFormView: View {
    @StateObject private var vm: IssueDetailedFormViewModel
    
    @State private var isPriorityPresented: Bool = false
    @State private var isStatusPresented: Bool = false
    @State private var isTypePresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Issue title", text: $vm.issue.name)
                .textFieldStyle(.susiePrimaryTextField)
            
            Button(action: {
                isStatusPresented.toggle()
            }, label: {
                HStack {
                    Spacer()
                    Text(vm.issue.status.description)
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
            
            ToggableSection(title: "Description", isToggled: true) {
                TextField("Description", text: $vm.issue.description, axis: .vertical)
                    .lineLimit(2...)
                    .textFieldStyle(.susieSecondaryTextField)
            }
            
            ToggableSection(title: "Details", isToggled: false) {
                ToggableSectionRowView(title: "Issue Priority") {
                    Button(action: { isPriorityPresented.toggle() }, label: {
                        TagView(text: vm.issue.priority.description, color: vm.issue.priority.color)
                    })
                }
                
                ToggableSectionRowView(title: "Issue Type") {
                    Button(action: { isTypePresented.toggle() }, label: {
                        TagView(text: vm.issue.type.description, color: vm.issue.type.color)
                    })
                }
                
                ToggableSectionRowView(title: "Issue Estimation") {
                    HStack {
                        Text(vm.issue.estimation.description)
                        Slider(value: .convert(from: $vm.issue.estimation), in: 1...20, step: 1)
                            .tint(Color.susieBlueSecondary)
                    }
                }
                
                ToggableSectionRowView(title: "Asignee", divider: false) {
                    Button(action: {
                        vm.assign()
                    }, label: {
                        HStack{
                            InitialsView(user: vm.issue.assignee, size: 30)
                            Text(vm.issue.assignee?.fullName ?? "Unassigned")
                        }
                    })
                }
            }
            
            Spacer()
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing, content: {
                Button("Save") {
                    vm.save()
                }
            })
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(vm.issue.name)
        .padding()
        .partialSheet(isPresented: $isPriorityPresented) {
            TagPickerView(enum: $vm.issue.priority, onSelect: {
                isPriorityPresented.toggle()
            })
        }
        .partialSheet(isPresented: $isTypePresented) {
            TagPickerView(enum: $vm.issue.type, onSelect: {
                isTypePresented.toggle()
            })
        }
        .partialSheet(isPresented: $isStatusPresented) {
            TagPickerView(enum: $vm.issue.status, onSelect: {
                isStatusPresented.toggle()
            })
        }
    }
    
    init(issue: Issue) {
        _vm = StateObject(wrappedValue: IssueDetailedFormViewModel(issue: issue))
    }
}
