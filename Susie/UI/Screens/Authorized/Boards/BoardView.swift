//
//  BoardView.swift
//  Susie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardView: View {
    @StateObject private var vm: BoardViewModel = BoardViewModel()
    let issues: Array<IssueGeneralDTO>
    let status: IssueStatus
    
    //Make task view flexible
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(status.description)
                    .padding(.leading)
                    .padding(.vertical, 4)
                    .bold()
                Text("\(issues.count)")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.horizontal,5)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.susieWhiteSecondary)
                    }
            }
            .offset(y: 10)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(issues) { issue in
                       IssueRowView(issue: issue)
                            .offset(y: 8)
                            .onTapGesture {
                                vm.fetchDeatils(for: issue)
                            }
                            .sheet(item: $vm.issue){ issue in
                                IssueOverviewView(issue: issue)
                            }
                    }
                }
            }
        }
    }
    
    init(issues: Array<IssueGeneralDTO>, status: IssueStatus) {
        self.status = status
        self.issues = issues.with(status: status)
    }
}

