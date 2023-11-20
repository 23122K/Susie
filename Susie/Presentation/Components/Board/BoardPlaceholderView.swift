//
//  BoardPlaceholderView.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/10/2023.
//

import SwiftUI
import Shimmer

struct BoardPlaceholderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(String.random(in: 0..<10))
                    .padding(.leading)
                    .padding(.vertical, 4)
                    .bold()
                Text(String.random(in: 0..<3))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.horizontal,5)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.susieWhiteSecondary)
                    }
            }
            .redacted(reason: .placeholder)
            .shimmering()
            .offset(y: 10)
            
            IssuePlaceholderView()
            
            Spacer()
        }
    }
}

#Preview {
    BoardPlaceholderView()
}
