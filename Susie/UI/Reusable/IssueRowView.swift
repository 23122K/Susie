//
//  IssueRowView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 10/03/2023.
//

import SwiftUI

struct IssueRowView: View {
    let title: String
    let tag: String
    let color: Color
    let assignetToInitials: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .padding(.bottom, 1)
                HStack(alignment: .bottom) {
                    IssueTypeView(content: tag, color: color)
                    IssuePriorityView(content: tag, color: color)
                    Spacer()
                    AssignedPersonView(initials: assignetToInitials, size: 30)
                        .padding(.trailing, 4)
                        .padding(.bottom, 4)
                }
                .padding(.horizontal, 1)
            }
            .padding(10)
        }
        .padding(.horizontal, 5)
        .background{
            RoundedRectangle(cornerRadius: 10)
            .fill(Color.susieWhiteSecondary)
            .padding(.horizontal, 10)
        }
    }
}

struct IssueRowView_Previews: PreviewProvider {
    static var previews: some View {
        IssueRowView(title: "Fix performance issues while fetching data", tag: "Bug", color: .red, assignetToInitials: "KL")
    }
}
