//
//  AssignedUserView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct AssignedUserView: View {
    let user: User?
    let size: CGFloat
    var body: some View {
        ZStack{
            Text(user?.initials ?? "?")
                .font(.callout)
                .foregroundColor(.blue)
                .bold()
                .background{
                    Circle()
                        .fill(.blue.opacity(0.2))
                        .frame(width: size, height: size)
                }

        }
    }
}
