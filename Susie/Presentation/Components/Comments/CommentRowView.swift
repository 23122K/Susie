//
//  CommentRowView.swift
//  Susie
//
//  Created by Patryk Maciąg on 23/10/2023.
//

import SwiftUI

struct CommentRowView: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                InitialsView(user: comment.author)
                Text(comment.author.fullName)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                Spacer()
            }
            Text(comment.body)
                .foregroundStyle(Color.gray)
        }
        .padding()
        .background(Color.susieWhiteSecondary.cornerRadius(9))
    }
}
