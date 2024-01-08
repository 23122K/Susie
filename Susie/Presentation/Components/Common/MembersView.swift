//
//  MembersView.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/10/2023.
//

import SwiftUI

struct MembersView: View {
    let users: Array<User>
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(users) { user in
                    VStack {
                        InitialsView(user: user, size: 45)
                        Text(verbatim: user.firstName)
                        Text(verbatim: user.lastName)
                    }
                    .font(.caption)
                }
            }
        }
    }
}
