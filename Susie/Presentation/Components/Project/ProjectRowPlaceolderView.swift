//
//  ProjectRowPlaceolderView.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/10/2023.
//

import SwiftUI
import Shimmer

struct ProjectRowPlaceholderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) { Spacer(minLength: 1) } //Makes view take all the space
            Text(String.random(in: 5..<15))
                .font(.headline)
                .shimmering()
            Text(String.random(in: 10..<30))
                .font(.callout)
                .lineLimit(1)
                .padding(.bottom, 5)
                .shimmering()
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 9)
                .fill(Color.susieWhiteSecondary)
        }
        .redacted(reason: .placeholder)
        .shimmering()
    }
}

#Preview {
    ProjectRowPlaceholderView()
}
