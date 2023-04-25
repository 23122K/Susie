//
//  BoardsView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardsView: View {
    @EnvironmentObject var logic: Logic
    var body: some View {
        VStack(alignment: .trailing){
            TabView {
                ForEach(0..<4) { i in
                    let filterdTasks = logic.tasks.filter{ $0.businessValue == i}
                    let boards = logic.getBoardNames()
                    GeometryReader { g in
                        BoardView(tasks: filterdTasks, tasksCount: filterdTasks.count, boardName: boards[i])
                    }
                    .frame(width: 380, height: 650)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

/*
struct BoardsView_Previews: PreviewProvider {
    static var previews: some View {
        BoardsView(tasks: [Task(id: 1, title: "Title", description: "Description", version: "1", deadline: "2", businessValue: 3, progress: 2, tag: "BUG")], boards: ["TO DO"])
    }
}
*/
