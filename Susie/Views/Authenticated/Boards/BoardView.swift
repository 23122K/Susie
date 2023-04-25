//
//  BoardView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardView: View {
    let tasks: Array<Task>
    let tasksCount: Int
    let boardName: String
    
    //State isPresented is used to toggle bettwen sheet and a task
    @State private var selectedTask: Task?
    
    //Make task view flexible
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(boardName)
                    .padding(.leading, 30)
                    .padding(.vertical, 4)
                    .bold()
                Text("\(tasksCount)")
                    .foregroundColor(.gray)
                    .padding(.horizontal,5)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.black)
                            .opacity(0.1)
                    }
            }
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(tasks) { task in
                        TaskView(title: task.title, tag: task.tag, color: task.color, assignetToInitials: "PM")
                            .offset(y: 8)
                            .onTapGesture {
                                self.selectedTask = task
                            }
                            .sheet(item: $selectedTask){ task in
                                TaskDetailedView(task: task)
                                    .presentationDetents([.medium])
                            }
                    }
                }
            }
        }
    }
}



struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(tasks: [Task(id: 1, title: "Test Title", description: "Description", version: "32", deadline: "23", businessValue: 1)], tasksCount: 1, boardName: "To do")
    }
}

