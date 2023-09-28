//
//  TaskOverviewView.swift
//  Scratchpad
//
//  Created by Patryk Maciąg on 29/04/2023.
//

import SwiftUI

struct IssueOverviewView: View {
    
    @State private var isTapped: Bool = false
    let issue: Issue
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomSection(title: "Description", content: {
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
                DetailedRowView(title: "Estimation", content: {
                    Text(issue.estimation.description)
                })
                Divider()
                DetailedRowView(title: "Asagniee", content: {
                    Text(issue.asignee?.firstName ?? "Unknown")
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

