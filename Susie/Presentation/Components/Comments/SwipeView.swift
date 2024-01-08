//
//  SwipeView.swift
//  Susie
//
//  Created by Patryk Maciąg on 23/10/2023.
//

import SwiftUI
import SwipeActions

struct SwipeContent<Content: View>: View {
    let content: Content
    let onDelete: (() -> Void)?
    let onEdit: (() -> Void)?
    
    var body: some View {
        SwipeView(label: {
            content
        }, leadingActions: { _ in
            SwipeAction(action: {
                onDelete?()
            }, label: { _ in
                HStack {
                    Text(.localized.delete)
                        .fontWeight(.semibold)
                    Image(systemName: "trash.fill")
                }
                .foregroundColor(Color.susieWhitePrimary)
            }, background: { _ in
                Color.red.opacity(0.95)
            })
            
        }, trailingActions: { _ in
            SwipeAction(action: {
               onEdit?()
            }, label: { _ in
                HStack {
                    Text(.localized.edit)
                    Image(systemName: "pencil")
                }
                .fontWeight(.semibold)
                .foregroundColor(Color.susieWhitePrimary)
            }, background: { _ in
                Color.susieBluePriamry
            })
        })
        .swipeSpacing(10)
        .swipeMinimumDistance(10)
        .swipeActionsStyle(.cascade)
        .swipeActionsMaskCornerRadius(9)
        .swipeActionCornerRadius(9)
        .padding(.horizontal)
    }
    
    init(@ViewBuilder _ content: @escaping () -> Content, onDelete: (() -> Void)? = nil, onEdit: (() -> Void)?  = nil){
        self.content = content()
        self.onDelete = onDelete
        self.onEdit = onEdit
    }
}

//#Preview {
//    SwipeView()
//}
