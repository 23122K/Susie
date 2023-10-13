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
    var body: some View {
        ZStack {
            Circle()
                .fill(.blue.opacity(0.2))
                .frame(width: size, height: size)
            Text(user?.initials ?? "?")
                .font(.callout)
                .foregroundColor(.blue)
                .bold()
            
        }
        .frame(width: size, height: size)
    }
}
