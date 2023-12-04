//
//  ToggableSection.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import SwiftUI

struct ToggableSection<Content: View> : View {
    @State private var isToggled: Bool
    @State private var angle: Double = 0
    
    var title: LocalizedStringResource
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 0) {
                Text(title)
                Spacer()
                Image(systemName: "chevron.right")
                    .rotationEffect(Angle(degrees: angle))
            }
            .fontWeight(.semibold)
            .foregroundColor(Color.gray)
            .onTapGesture {
                isToggled.toggle()
                withAnimation(.spring(response: 0.2)) {
                    angle = 90
                }
                angle = isToggled ? 90: 0
            }
        
            if isToggled { content() }
            
        }
        .padding()
        .background(Color.susieWhiteSecondary)
        .cornerRadius(9)
        .transition(.move(edge: .top))
        .animation(.spring(response: 0.2), value: isToggled)
    }
    
    init(title: LocalizedStringResource, isToggled: Bool = false, @ViewBuilder _ content: @escaping () -> Content){
        self.title = title
        self.content = content
        _isToggled = State(initialValue: isToggled)
    }
}
