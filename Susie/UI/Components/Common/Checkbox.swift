//
//  Checkbox.swift
//  Scratchpad
//
//  Created by Patryk Maciąg on 03/05/2023.
//

import SwiftUI

struct Checkbox: View {
    @Binding var isSelected: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.susieWhiteSecondary)
                .frame(width: 25, height: 25)
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.susieBluePriamry)
                .opacity(isSelected ? 1 : 0)
                .frame(width: 20, height: 20)
                .animation(.spring(), value: isSelected)
            Image(systemName: "checkmark")
                .fontWeight(.bold)
                .opacity(isSelected ? 1 : 0)
                .foregroundColor(Color.susieWhitePrimary)
                .frame(width: 20, height: 20)
        }
        .onTapGesture { isSelected.toggle() }
    }
    
    init(isSelected: Binding<Bool>) {
        _isSelected = isSelected
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(isSelected: .constant(false))
    }
}
