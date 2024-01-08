//
//  DefinitionOfDoneFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/12/2023.
//

import SwiftUI
import Factory

struct DefinitionOfDoneFormView: View {
    @Environment (\.dismiss) var dimiss
    @ObservedObject var vm: DefinitionOfDoneFormViewModel
    @FocusState var focus: DefinitionOfDoneFormViewModel.Field?
    
    var body: some View {
        NavigationStack {
            TextEditor(text: $vm.rule.definition)
                .focused($focus, equals: .definition)
                .textFieldStyle(.susieSecondaryTextField)
                .onChange(of: vm.dismiss) { _ in dimiss() }
                .padding(.horizontal)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button("\(.localized.cancel)") {
                            vm.dismissButtonTapped()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("\(.localized.save)") {
                            vm.dismissButtonTapped()
                        }
                    }
                }
        }
        .bind($vm.focus, to: $focus)
    }
    
    init(project: Project, rule: Rule? = nil) {
        self._vm = ObservedObject(wrappedValue: DefinitionOfDoneFormViewModel(project: project, rule: rule))
    }
}

#Preview {
    DefinitionOfDoneFormView(project: .mock)
}
