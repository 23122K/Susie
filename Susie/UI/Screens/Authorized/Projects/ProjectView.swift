//
//  ProjectFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 29/09/2023.
//

import SwiftUI

struct ProjectView: View {
    @StateObject private var vm: ProjectViewModel
    var body: some View {
        VStack{
            TextField("eg. Operation blackout", text: $vm.name)
            TextField("eg. it's really fun", text: $vm.description)
            
            Button("Save") {
                vm.save()
            }
            .buttonStyle(.primary)
        }
        .navigationTitle(vm.name.isEmpty ? "New project" : vm.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(project: ProjectDTO? = nil) {
        _vm = StateObject(wrappedValue: ProjectViewModel(project: project))
    }
}
