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
    
    @StateObject private var vm: IssueFormViewModel
    @FocusState private var focusedField: FocusedField?
    
    @State private var isEstimationPresented: Bool = false
    @State private var isPriorityPresented: Bool = false
    @State private var isTypePresented: Bool = false
    
    private enum FocusedField: Hashable {
        case title
        case description
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Issue title", text: $vm.issue.name)
                .textFieldStyle(.susiePrimaryTextField)
                .focused($focusedField, equals: .title)
                .onSubmit { focusedField = .description }
            
            
            ToggableSection(title: "Description", isToggled: true) {
                TextField("Description", text: $vm.issue.description, axis: .vertical)
                    .lineLimit(2...)
                    .textFieldStyle(.susieSecondaryTextField)
                    .focused($focusedField, equals: .description)
                    .onSubmit { focusedField = .description }
            }
            .animation(.bouncy)
            
            ToggableSection(title: "Details", isToggled: true) {
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
                ToggableSectionRowView(title: "Issue Estimation", divider: false) {
                    HStack {
                        Text("\(vm.issue.estimation.description)")
                        Slider(value: .convert(from: $vm.issue.estimation), in: 1...20, step: 1)
                            .tint(Color.susieBlueSecondary)
                    }
                }
                
            }
        }
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
        .padding()
        .navigationTitle(vm.issue.name)
        .toolbar(.hidden, for: .tabBar)
        .toolbar{
            Button("Save") {
                vm.create()
                dismiss()
            }
        }
        .onAppear{ focusedField = .title }
    }
    
    init(project: ProjectDTO) {
        _vm = StateObject(wrappedValue: IssueFormViewModel(project: project))
    }
}


struct ToggableSectionRowView<Content: View>: View {
    let title: String
    let content: Content
    let divider: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                    content
                }
                .padding(.bottom, 5)
                .foregroundColor(.gray)
                Spacer()
            }
            .padding(.top, 5)
            
            if divider { Divider() }
        }
    }
    
    init(title: String, divider: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.divider = divider
        self.content = content()
    }
}
