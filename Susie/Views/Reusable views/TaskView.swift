//
//  TaskView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 10/03/2023.
//

import SwiftUI

struct TaskView: View {
    let title: String
    let tag: String
    let color: Color
    let assignetToInitials: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .padding(.bottom, 1)
                HStack(alignment: .bottom) {
                    TagView(tag: tag, color: color)
                    PriotiryIndicatorView(color: .red, text: "Urgent")
                    Spacer()
                    AssignedPersonView(initials: assignetToInitials, size: 30)
                        .padding(.trailing, 4)
                        .padding(.bottom, 4)
                }
                .padding(.horizontal, 1)
            }
        }
        .padding(7)
        .padding(.horizontal, 10)
        .background{
            RoundedRectangle(cornerRadius: 15)
            .fill(.white)
            .padding(.horizontal, 10)
            .shadow(color: Color.gray,
                    radius: 3,
                    x: 0.1, // Horizontal offset
                    y: 3) // Vertical offset
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(title: "Fix performance issues while fetching data", tag: "Bug", color: .red, assignetToInitials: "KL")
    }
}
