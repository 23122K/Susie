//
//  Checkbox.swift
//  Scratchpad
//
//  Created by Patryk Maciąg on 03/05/2023.
//

import SwiftUI

struct Checkbox: View {
    @Binding private var isSelected: Bool
    private let title: String
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            ZStack {
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.susieWhiteSecondary)
                    .frame(width: 20, height: 20)
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.susieBluePriamry)
                    .opacity(isSelected ? 1 : 0)
                    .frame(width: 20, height: 20)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: isSelected)
                Image(systemName: "checkmark")
                    .fontWeight(.bold)
                    .transition(.move(edge: .bottom))
                    .opacity(isSelected ? 1 : 0)
                    .foregroundColor(Color.susieWhitePrimary)
                    .frame(width: 20, height: 20)
            }
            .onTapGesture { isSelected.toggle() }
            
            Text(title)
                .font(.callout)
            
            Spacer()
        }
    }
    
    init(title: String, isSelected: Binding<Bool>) {
        _isSelected = isSelected
        self.title = title
    }
}

