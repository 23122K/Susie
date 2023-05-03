//
//  TaskOverviewView.swift
//  Scratchpad
//
//  Created by Patryk Maciąg on 29/04/2023.
//

import SwiftUI

struct IssueOverviewView: View {
    
    @State private var isTapped: Bool = false
    let issue: Task
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomSection(title: "Description", content: {
                //Had to use this uga buga shit trick to make section take all screen width without using baga bongo magic
                HStack{
                    HStack{
                        Text(issue.description)
                    }
                    Spacer(minLength: 1)
                }
            })
            
            CustomSection(title: "Issue status", bordered: false, content: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green.opacity(0.7))
                        .frame(height: 50)
                    Text("DONE")
                        .bold()
                        .foregroundColor(.white)
                }
            })
        
            CustomSection(title: "Details", content: {
                DetailedRowView(title: "Issue type", content: {
                    Text(issue.tag)
                })
                Divider()
                DetailedRowView(title: "Priority", content: {
                    Text(issue.businessValue.description)
                })
                Divider()
                DetailedRowView(title: "Due date", content: {
                    Text(issue.deadline)
                })
                Divider()
                DetailedRowView(title: "Asagniee", content: {
                    Text(issue.assignee?.firstname ?? "Unknown")
                })
                Divider()
                DetailedRowView(title: "Logged time", content: {
                    Text("00:00:00")
                })
            })
            
            CustomSection(title: "Issue status", bordered: false, content: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isTapped ? .red.opacity(0.7) : .blue.opacity(0.7))
                        .frame(height: 50)
                    HStack{
                        Text(isTapped ? "Stop logging time" : "Start logging time ")
                            .bold()
                            .foregroundColor(.white)
                        Image(systemName: isTapped ? "stop.fill" : "play.fill")
                            .foregroundColor(.white)
                    }
                }
                .onTapGesture {
                    isTapped.toggle()
                }
            })
        }.padding()
    }
}

struct IssueOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        IssueOverviewView(issue: Task(id: 1, title: "Test", description: "Test", version: "3.4", deadline: "23:12:2023", businessValue: 4))
    }
}
