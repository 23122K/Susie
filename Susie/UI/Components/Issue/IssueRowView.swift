//
//  IssueRowView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 10/03/2023.
//

import SwiftUI

struct IssueRowView: View {
    let issue: IssueGeneralDTO
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(issue.name)
                    .bold()
                    .padding(.bottom, 1)
                HStack(alignment: .bottom) {
//                    IssueTypeView(content: issue., color: color)
//                    IssuePriorityView(content: tag, color: color)
                    Spacer()
                    InitialsView(user: issue.asignee, size: 30)
                }
                .padding(.all, 5)
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .background{
            RoundedRectangle(cornerRadius: 10)
            .fill(Color.susieWhiteSecondary)
        }
    }
}

