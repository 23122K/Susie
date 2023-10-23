//
//  IssueRowView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 10/03/2023.
//

import SwiftUI

struct IssueRowView: View {
    let flagImage: Image =  Image(systemName: "flag")
    let issue: IssueGeneralDTO
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading) {
                Text(issue.name)
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                    .offset(y: 3)
                
                HStack(alignment: .center) {
                    TagView(text: issue.type.description, color: issue.type.color)
                    TagView(image: flagImage, text: issue.priority.description, color: issue.priority.color)
                    Spacer()
                    InitialsView(user: issue.assignee, size: 30)
                }
                .offset(y: -3)
            }
            .padding(.horizontal, 5)
        }
        .padding(.all, 5)
        .background{
            RoundedRectangle(cornerRadius: 10)
            .fill(Color.susieWhiteSecondary)
        }
    }
}
