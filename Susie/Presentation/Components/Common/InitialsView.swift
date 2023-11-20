//
//  InitialsView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct InitialsView: View {
    let user: User?
    let size: CGFloat
    let optionalText: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.blue.opacity(0.2))
                .frame(width: size, height: size)
            Text(user?.initials ?? optionalText)
                .font(.callout)
                .foregroundColor(.blue)
                .bold()
            
        }
        .frame(width: size, height: size)
    }
    
    init(user: User?, size: CGFloat = 30, optionalText: String = "?") {
        self.user = user
        self.size = size
        self.optionalText = optionalText
    }
}
