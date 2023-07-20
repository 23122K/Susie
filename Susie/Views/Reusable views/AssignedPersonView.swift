//
//  AssignedPersonView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct AssignedPersonView: View {
    let initials: String
    let size: CGFloat
    var body: some View {
        ZStack{
            Text(initials)
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

struct AssignedPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AssignedPersonView(initials: "PM", size: 40)
    }
}
