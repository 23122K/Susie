//
//  BoardView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardView: View {
    let issues: Array<Issue>
    let issueCount: Int
    let boardName: String
    
    //State isPresented is used to toggle bettwen sheet and a task
    @State private var selectedIssue: Issue?
    @State private var isPresented: Bool = false
    
    //Make task view flexible
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(boardName)
                    .padding(.leading, 30)
                    .padding(.vertical, 4)
                    .bold()
                Text("\(issueCount)")
                    .foregroundColor(.gray)
                    .padding(.horizontal,5)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.black)
                            .opacity(0.1)
                    }
            }
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(issues) { issue in
                        IssueView(title: issue.title, tag: issue.tag, color: issue.color, assignetToInitials: "PM")
                            .offset(y: 8)
                            .onTapGesture {
                                self.selectedIssue = issue
                            }
                            .sheet(item: $selectedIssue){ issue in
                                IssueDetailedView(issue: issue)
                                    .presentationDetents([.large])
                            }
                    }
                }
            }
        }
    }
}


struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(issues: [Issue(id: 1, title: "Test Title", description: "Description", version: "32", deadline: "23", businessValue: 1)], issueCount: 1, boardName: "To do")
    }
}

