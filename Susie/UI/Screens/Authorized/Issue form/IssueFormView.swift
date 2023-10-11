//
//  IssueFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 28/09/2023.
//

import SwiftUI

struct IssueFormView: View {
    @StateObject private var vm: IssueFormViewModel
    var body: some View {
        VStack {
            TextField("Name", text: $vm.name)
            TextField("Description", text: $vm.description)
            Picker("Estimation", selection: $vm.estimation) {
                ForEach(0...10, id: \.self) { number in
                    Text("\(number)").tag(Int32(number))
                }
            }
            
            Picker("Issue type", selection: $vm.type, content: {
                ForEach(IssueType.allCases, id: \.rawValue) { type in
                    Text("\(type.description)").tag(type)
                }
            })
            
            Picker("Issue priority", selection: $vm.priority) {
                ForEach(IssuePriority.allCases, id: \.rawValue) { priority in
                    Text(priority.description).tag(priority)
                }
            }
            
            Button("Create") {
                vm.create()
            }
        }
    }
    
    init(project: Project) {
        _vm = StateObject(wrappedValue: IssueFormViewModel(project: project))
    }
}
