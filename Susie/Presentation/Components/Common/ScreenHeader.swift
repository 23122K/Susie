//
//  ScreenHeader.swift
//  Justlift
//
//  Created by Patryk Maciąg on 14/09/2023.
//

import SwiftUI

struct ScreenHeader<Content: View>: View {
    let user: User?
    let title: LocalizedStringResource
    let content: Content?
    
    let action: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            InitialsView(user: user, size: 30)
                .onTapGesture { action?() }
            Spacer()
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            content
        }
        .padding(.horizontal)
    }
    
    init(user: User?, title: LocalizedStringResource, action: (() -> Void)? = nil,  @ViewBuilder content: @escaping () -> Content?) {
        self.user = user
        self.title = title
        
        self.action = action
        self.content = content()
    }
}
