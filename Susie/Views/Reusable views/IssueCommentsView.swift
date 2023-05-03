//
//  IssueCommentsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 02/05/2023.
//

import SwiftUI

struct IssueCommentsView: View {
    @State private var comment: String = ""
    var body: some View {
        VStack{
            Spacer()
            HStack {
                   TextField("Message...", text: $comment)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                      .frame(minHeight: CGFloat(30))
                Button {
                   print("XD")
                } label: {
                    Text("Send")
                }
                }.frame(minHeight: CGFloat(50)).padding()
        }
    }
}

struct IssueCommentsView_Previews: PreviewProvider {
    static var previews: some View {
        IssueCommentsView()
    }
}
