//
//  TaskDetailedView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct TaskDetailedView: View {
    let task: Task
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 120, height: 5)
                .opacity(0.15)
            VStack(alignment: .leading) {
                
                Text(task.title)
                    .font(.title)
                    .bold()
                    .padding(.bottom, 5)
                    .padding(.top, 20) //Make swipe rect be above
                
                Text(task.description)
                    .padding(.bottom, 10)
                HStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 170, height: 100)
                    Spacer()
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 170, height: 100)
                }
                .opacity(0.2)
            }
            .padding()
        }
    }
}

/*
struct TaskDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailedView(task: scrumapp.Task(id: UUID(), title: "Test title ", description: "Test description", tag: "Bug", AssignedPerson: "KL", progress: 1))
    }
}
*/
