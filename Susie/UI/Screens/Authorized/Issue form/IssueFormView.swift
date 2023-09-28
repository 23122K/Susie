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
                ForEach(0..<7, id: \.self) { number in
                    Text("\(number)").tag(Int32(number))
                }
            }
            
            Picker("Issue type", selection: $vm.type) {
                ForEach(vm.types, id: \.id) { type in
                    Text(type.description).tag(type as IssueType?)
                }
            }
            
            Picker("Issue priority", selection: $vm.priority) {
                ForEach(vm.priorities, id: \.id) { priority in
                    Text(priority.description).tag(priority as IssuePriority?)
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

//struct IssueFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        IssueFormView()
//    }
//}
