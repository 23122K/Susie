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
                    }
                }, placeholder: EmptyView())
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(vm.sprint.name)
            .refreshable { vm.fetchSprints() }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Menu(content: {
                        Button(action: {
                            vm.startSprintButtonTapped()
                            dismiss()
                        }, label: {
                            Text("Start")
                            Image(systemName: "play.fill")
                        })
                        
                        NavigationLink(destination: {
                            SprintFormView(sprint: vm.sprint, project: vm.project)
                        }, label: {
                            Text("Edit")
                            Image(systemName: "pencil")
                        })
                        
                        Section {
                            Button(role: .destructive, action: {
                                vm.deleteSprintButtonTapped()
                                dismiss()
                            }, label: {
                                Text("Delete")
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
        .sheet(item: $vm.issue) { issue in
            IssueDetailsView(issue: issue)
        }
        
    }
    
    init(sprint: Sprint, project: Project) { self._vm = ObservedObject(initialValue: SprintViewModel(sprint: sprint, project: project)) }
}
