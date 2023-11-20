//
//  IssuePlaceholderView.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/10/2023.
//

import SwiftUI

struct IssuePlaceholderView: View {
    private let range: ClosedRange = 2...4
    var body: some View {
        VStack {
            ForEach(range, id: \.self) { _ in
                IssueRowPlaceholderView()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    IssuePlaceholderView()
}
