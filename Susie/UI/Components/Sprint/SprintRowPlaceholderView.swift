//
//  SprintRowPlaceholderView.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/10/2023.
//

import SwiftUI
import Shimmer

struct SprintRowPlaceholderView: View {
    var body: some View {
        GeometryReader { reader in
            HStack {
                VStack(alignment: .leading) {
                    Text(String.random(in: 10..<20))
                        .font(.title)
                        .shimmering()
                }
                .padding()
                Spacer()
            }
            .frame(width: reader.size.width, height: 200)
            .fontWeight(.semibold)
            .background(Color.susieWhiteSecondary)
            .cornerRadius(9)
            .redacted(reason: .placeholder)
            .shimmering()
        }
        .padding()
    }
}

#Preview {
    SprintRowPlaceholderView()
}
