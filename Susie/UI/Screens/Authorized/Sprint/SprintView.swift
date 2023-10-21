//
//  SprintView.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import SwiftUI

struct SprintView: View {
    @Environment (\.dismiss) var dismiss
    @StateObject private var sprintViewModel: SprintViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                //TODO: Remove state from sprintViewModle and rename it to issue
                AsyncContentView(state: $sprintViewModel.state, { issues in
                    ForEach(issues) { issue in
                        IssueRowView(issue: issue)
                            .padding()
                    }
                }, placeholder: EmptyView(), onAppear: {
                    sprintViewModel.fetch()
                })
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(sprintViewModel.sprint.name)
            .refreshable {
                sprintViewModel.fetch()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Menu(content: {
                        Button(action: {
                            sprintViewModel.start()
                            dismiss()
                        }, label: {
                            Text("Start")
                            Image(systemName: "play.fill")
                        })
                        
                        NavigationLink(destination: {
                            SprintFormView(sprint: sprintViewModel.sprint, project: sprintViewModel.project)
                        }, label: {
                            Text("Edit")
                            Image(systemName: "pencil")
                        })
                        
                        Section {
                            Button(role: .destructive, action: {
                                sprintViewModel.delete()
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
        .sheet(item: $sprintViewModel.issue) { issue in
            IssueDetailsView(issue: issue)
        }
        .onAppear{
            sprintViewModel.fetch()
        }
        
    }
    
    init(sprint: Sprint, project: ProjectDTO) {
        _sprintViewModel = StateObject(wrappedValue: SprintViewModel(sprint: sprint, project: project))
    }
}

//struct SprintView_Previews: PreviewProvider {
//    static var previews: some View {
//        SprintView()
//    }
//}
