//
//  TaskDetailedView.swift
//  Scratchpad
//
//  Created by Patryk Maciąg on 27/04/2023.
//

import SwiftUI

struct IssueDetailedView: View {
    let issue: Task
    
    @State private var isPresented: Bool = false
    
    //Overview - false | Comments = true
    @State private var isAcitve: Bool = false
    
    @State private var height: CGFloat = 200
    var body: some View {
        VStack(alignment: .leading){
            //Title
            VStack(alignment: .leading){
                Text(issue.title)
                    .font(.system(size: 30))
                    .bold()
                    .padding(.top, 10)
                
                HStack(spacing: 0){
                    VStack{
                        Text("Overview")
                            .bold(!isAcitve ? true : false)
                            .foregroundColor(!isAcitve ? .blue : .gray)
                            .offset(y: 10)
                        RoundedRectangle(cornerRadius: 1)
                            .fill(!isAcitve ? .blue : .gray)
                            .frame(height: 5)
                    }
                    VStack{
                        Text("Comments")
                            .bold(isAcitve ? true : false)
                            .foregroundColor(isAcitve ? .blue : .gray)
                            .offset(y: 10)
                        RoundedRectangle(cornerRadius: 1)
                            .fill(isAcitve ? .blue : .gray)
                            .frame(height: 5)
                    }
                }
            }.padding(.horizontal)
            
            TabView(content: {
                IssueOverviewView(issue: issue)
                    .onAppear{
                        isAcitve = false
                    }
                IssueCommentsView()
                    .onAppear{
                        isAcitve = true
                    }
                
            })
            Spacer()
        }
    }
}

/*
struct IssueDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        IssueDetailedView(issue: )
    }
}
*/
