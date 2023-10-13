//
//  SprintView.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import SwiftUI

struct SprintView: View {
    @Environment (\.dismiss) var dismiss
    @State private var appeared: Bool = false
    
    @StateObject private var sprint: SprintViewModel
    @ObservedObject private var sprints: SprintsViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(sprint.issues) { issue in
                    IssueRowView(issue: issue)
                        .animation(.spring, value: appeared)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(sprint.name)
            .refreshable {
                sprint.fetch()
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
                            sprint.start()
                        }, label: {
                            Text(sprint.isAcitve ? "Complete" : "Start")
                            Image(systemName: sprint.isAcitve ? "pause.fill" : "play.fill")
                        })
                        
                        NavigationLink(destination: {
                            SprintFormView(project: sprints.project, sprint: sprints.sprint)
                        }, label: {
                            Text("Edit")
                            Image(systemName: "pencil")
                        })
                        
                        Section {
                            Button(role: .destructive, action: {
                                sprint.delete()
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
        .onAppear{
            appeared.toggle()
            sprint.fetch()
        }
        
    }
    
    init(sprints: SprintsViewModel) {
        self.sprints = sprints
        _sprint = StateObject(wrappedValue: SprintViewModel(sprint: sprints.sprint))
    }
}

//struct SprintView_Previews: PreviewProvider {
//    static var previews: some View {
//        SprintView()
//    }
//}
