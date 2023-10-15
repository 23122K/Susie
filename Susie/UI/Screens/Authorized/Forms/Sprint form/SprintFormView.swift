//
//  SprintFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/10/2023.
//

import SwiftUI

struct SprintFormView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject private var sprint: SprintFromViewModel
    @FocusState private var focusedField: FocusedField?
    
    private enum FocusedField: Hashable {
        case name
        case goal
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Sprint name", text: $sprint.name)
                .padding(.horizontal)
                .focused($focusedField, equals: .name)
                .onSubmit { focusedField = .goal}
                .textFieldStyle(.susiePrimaryTextField)
            
            TextField("Goal", text: $sprint.goal)
                .padding(.horizontal)
                .focused($focusedField, equals: .goal)
                .textFieldStyle(.susieSecondaryTextField)
            
            Toggle("Start date", isOn: $sprint.shouldHaveStartDate)
                .padding(.horizontal)
                .tint(.susieBluePriamry)
            
            DatePicker("Start date", selection: $sprint.date)
                .padding(.horizontal)
                .disabled(!sprint.shouldHaveStartDate)
                .opacity(sprint.shouldHaveStartDate ? 1 : 0)
                .datePickerStyle(.graphical)
                .animation(.spring, value: sprint.shouldHaveStartDate)
        }
        .toolbar {
            Button("Save") {
                sprint.save()
                dismiss()
            }
        }
        .padding(.vertical)
        .onAppear{ focusedField = .name }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(sprint.name.isEmpty ? "New sprint" : sprint.name)
    }
    
    init(sprint: Sprint? = nil) {
        _sprint = StateObject(wrappedValue: SprintFromViewModel(sprint: sprint))
    }
}

//struct SprintFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        SprintFormView()
//    }
//}
