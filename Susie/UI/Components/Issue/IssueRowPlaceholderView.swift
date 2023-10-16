//
//  IssueRowPlaceholderView.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/10/2023.
//

import SwiftUI
import Shimmer

struct IssueRowPlaceholderView: View {
    private let image = Image(systemName: "flag")
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading) {
                Text(String.random(in: 0..<30))
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                    .offset(y: 3)
                    .shimmering()
                
                HStack(alignment: .center) {
                    TagView(text: IssueType.allCases.randomElement()!.description, color: IssueType.allCases.randomElement()!.color)
                        .shimmering()
                    TagView(image: image, text: IssuePriority.allCases.randomElement()!.description, color: IssuePriority.allCases.randomElement()!.color)
                        .shimmering()
                    Spacer()
                    InitialsView(user: User(email: "", firstName: "X", lastName: "X"), size: 30)
                        .shimmering()
                }
                .offset(y: -3)
            }
            .padding(.horizontal, 5)
        }
        .redacted(reason: .placeholder)
        .shimmering()
        .padding(.all, 5)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.susieWhiteSecondary)
        }
    }
}

#Preview {
    IssueRowPlaceholderView()
}
