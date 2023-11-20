//
//  CreateSprintView.swift
//  Susie
//
//  Created by Patryk Maciąg on 11/10/2023.
//

import SwiftUI

struct CreateSprintView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack{ Spacer () }
            Image(systemName: "plus")
                .scaleEffect(2)
                .padding(.bottom, 5)
            Text("Create sprint")
        }
        .frame(height: 200)
        .fontWeight(.semibold)
        .foregroundColor(.gray)
        .background(Color.susieWhiteSecondary)
        .cornerRadius(9)
        .padding()
    }
}

#Preview {
    CreateSprintView()
}
