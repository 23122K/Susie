//
//  DefinitionOfDoneView.swift
//  Susie
//
//  Created by Patryk Maciąg on 04/12/2023.
//

import SwiftUI

struct DefinitionOfDoneView: View {
    @ObservedObject var vm: DefinitionOfDoneViewModel
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView {
                    AsyncContentView(state: $vm.rules) { rules in
                        ForEach(Array(rules.enumerated()), id: \.element) { index, rule in
                            SwipeContent({
                                RuleRowView(index: index, rule: rule).onTapGesture { vm.selectRuleButtonTapped(on: rule) }
                            }, onDelete: {
                                vm.deleteButtonTapped(on: rule)
                            }, onEdit: {
                                vm.selectRuleButtonTapped(on: rule)
                            })
                        }
                    }
                }
                .font(.subheadline)
                .scrollIndicators(.hidden)
                .refreshable{ await vm.onAppear() }
            }
            .task { await vm.onAppear()}
            .navigationTitle("\(LocalizedStringResource.localized.definitionOfDone)")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        vm.createRuleButtonTapped()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.susieBluePriamry)
                    })
                }
            }
        }
        .fullScreenCover(item: $vm.destination) { destination in
            switch destination {
            case let .edit(rule):
                DefinitionOfDoneFormView(project: vm.project, rule: rule)
            case .create:
                DefinitionOfDoneFormView(project: vm.project)
            }
        }
    }
    
    init(project: Project) {
        self._vm = ObservedObject(wrappedValue: DefinitionOfDoneViewModel(project: project))
    }
}

#Preview {
    DefinitionOfDoneView(project: .mock)
}
