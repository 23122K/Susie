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
    private var sprint: Sprint //TODO: Remove it and take value from sprintViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(sprintViewModel.issues) { issue in
                    IssueRowView(issue: issue)
                        .onTapGesture { sprintViewModel.issue = issue }
                }
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
                            switch sprintViewModel.sprint.active {
                            case true:
                                sprintViewModel.stop()
                            case false:
                                sprintViewModel.start()
                            }
                        }, label: {
                            Text(sprintViewModel.sprint.active ? "Complete" : "Start")
                            Image(systemName: sprintViewModel.sprint.active ? "pause.fill" : "play.fill")
                        })
                        
                        NavigationLink(destination: {
                            SprintFormView(sprint: sprint)
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
    
    init(sprint: Sprint, project: Project) {
        self.sprint = sprint
        _sprintViewModel = StateObject(wrappedValue: SprintViewModel(sprint: sprint, project: project))
    }
}

//struct SprintView_Previews: PreviewProvider {
//    static var previews: some View {
//        SprintView()
//    }
//}
