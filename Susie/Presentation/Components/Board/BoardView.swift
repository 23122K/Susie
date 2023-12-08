//
//  BoardView.swift
//  Susie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardView: View {
    @State private var issue: IssueGeneralDTO?
    
    private let issues: Array<IssueGeneralDTO>
    private let status: IssueStatus?
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(status?.description ?? LocalizedStringResource.localized.myIssues.asString)
                    .padding(.leading)
                    .padding(.vertical, 4)
                    .bold()
                Text(verbatim: "\(issues.count)")
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
                            .padding(.horizontal)
                            .offset(y: 8)
                            .onTapGesture {
                                self.issue = issue
                            }
                    }
                }
            }
        }
        .fullScreenCover(item: $issue) { issue in
            IssueDetailsView(issue: issue)
        }
    }
    
    init(issues: Array<IssueGeneralDTO>, status: Optional<IssueStatus> = nil) {
        switch status {
        case let .some(status):
            self.status = status
            self.issues = issues.with(status: status)
        case .none:
            self.status = status
            self.issues = issues
        }
    }
}

