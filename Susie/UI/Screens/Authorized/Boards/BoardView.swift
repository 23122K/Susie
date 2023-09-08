//
//  BoardView.swift
//  Susie
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
                        IssueRowView(title: issue.name, tag: "TEST", color: Color.red, assignetToInitials: "PM")
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

