//
//  RuleRowView.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/12/2023.
//

import SwiftUI

struct RuleRowView: View {
    let index: Int
    var rule: Rule
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                CountIndicator(count: index + 1, backgorundColor: .susieBluePriamry, foregorundColor: .susieWhitePrimary)
                    .padding(.trailing, 5)
                Text(verbatim: rule.definition)
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.all, 5)
        }
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.susieWhiteSecondary)
        }
    }
}

