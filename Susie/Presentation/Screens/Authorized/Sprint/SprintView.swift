//
//  SprintView.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import SwiftUI

struct SprintView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var vm: SprintViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                AsyncContentView(state: $vm.issues, { issues in
                    ForEach(issues) { issue in
                        IssueRowView(issue: issue)
                            .onTapGesture { vm.destinationButtonTapped(for: .details(issue)) }
                    }
                }, placeholder: EmptyView())
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(vm.sprint.name)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("\(.localized.close)") {
                        vm.dismissButtonTapped()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Menu(content: {
                        Button(action: {
                            vm.startSprintButtonTapped()
                            vm.dismissButtonTapped()
                        }, label: {
                            Text(.localized.start)
                            Image(systemName: "play.fill")
                        })
                        
                        NavigationLink(destination: {
                            SprintFormView(sprint: vm.sprint, project: vm.project)
                        }, label: {
                            Text(.localized.edit)
                            Image(systemName: "pencil")
                        })
                        
                        Section {
                            Button(role: .destructive, action: {
                                vm.deleteSprintButtonTapped()
                                vm.dismissButtonTapped()
                            }, label: {
                                Text(.localized.delete)
                                    .foregroundColor(.red)
                                Image(systemName: "trash.fill")
                                    .foregroundStyle(.red)
                            })
                        }
                    }, label: {
                        Image(systemName: "ellipsis")
                    })
                }
            }
        }
        .refreshable { vm.onAppear() }
        .onAppear{ vm.onAppear() }
        .onChange(of: vm.dismiss) { _ in dismiss() }
        .fullScreenCover(item: $vm.destination) { destination in
            switch destination {
            case let .details(issue: issue):
                IssueDetailsView(issue: issue)
            }
        }
    }
    
    init(sprint: Sprint, project: Project) { self._vm = ObservedObject(initialValue: SprintViewModel(sprint: sprint, project: project)) }
}
