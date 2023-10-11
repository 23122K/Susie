//
//  SprintFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/10/2023.
//

import SwiftUI

struct SprintFormView: View {
    @StateObject private var sprint: SprintFromViewModel
    var body: some View {
        VStack {
            TextField("Name", text: $sprint.name)
            DatePicker("Start date", selection: $sprint.date)
            
            Button("Save") {
                sprint.save()
            }
            .buttonStyle(.primary)
            
        }
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
