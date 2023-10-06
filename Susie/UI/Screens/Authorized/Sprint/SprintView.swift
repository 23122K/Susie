//
//  SprintView.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import SwiftUI

struct SprintView: View {
    @Environment (\.dismiss) var dismiss
    
    @StateObject private var sprint: SprintViewModel
    @ObservedObject private var sprints: SprintsViewModel
    
    var body: some View {
        ScrollView {
            HStack {
                Text(sprint.name)
                    .font(.title)
                    .fontWeight(.semibold)
                Button("Close") {
                    dismiss()
                }
            }
            
            ForEach(sprint.issues) { issue in
                IssueRowView(issue: issue)
            }
            
            Menu("Options", content: {
                Button("Start") {
                    sprint.start()
                }
            })
            
            Spacer()
        }
        .padding()
        .onAppear{ sprint.fetch() }
        
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
