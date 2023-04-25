//
//  PriotiryIndicatorView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct PriotiryIndicatorView: View {
    var body: some View {
        ZStack{
            Text("Normal")
                .brightness(0.1)
                .foregroundColor(Color.green)
                .bold()
                .font(.caption)
                .padding(.horizontal, 7)
                .padding(.vertical, 7)
                .background{
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.green)
                        .opacity(0.2)
                }
        }
    }
}

struct PriotiryIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        PriotiryIndicatorView()
    }
}
