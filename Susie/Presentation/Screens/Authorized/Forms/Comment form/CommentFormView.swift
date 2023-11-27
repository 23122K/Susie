//
//  CommentFormView.swift
//  Susie
//
//  Created by Patryk Maciąg on 26/10/2023.
//

import SwiftUI

struct CommentFormView: View {
    @Environment (\.dismiss) private var dismiss
    @FocusState private var focus: Field?
    @Binding var comment: Comment
    
    private enum Field: Hashable {
        case message
    }
    
    var onSubmit: () -> Void
    
    var body: some View {
        VStack{
            TextField(comment.body, text: $comment.body, axis: .vertical)
                .focused($focus, equals: .message)
                .textFieldStyle(.susieSecondaryTextField)
                .lineLimit(4...)
                .onSubmit { save() }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Dismiss") { dismiss() }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Save") { save() }
            }
        }
    }
    
    private func save() {
        onSubmit()
        dismiss()
    }
    
    init(comment: Binding<Comment>, onSubmit: @escaping () -> Void) {
        _comment = comment
        self.onSubmit = onSubmit
    }
}

//#Preview {
//    CommentFormView()
//}
