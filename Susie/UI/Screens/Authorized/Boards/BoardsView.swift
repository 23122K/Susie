//
//  BoardsView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardsView: View {
    @EnvironmentObject var vm: ClientViewModel
    var body: some View {
        VStack(alignment: .trailing){
            TabView {
                ForEach(0..<4) { i in
                    let filterIssues = vm.issues.filter{ $0.status == i}
                    let boards = vm.getBoardNames()
                    GeometryReader { g in
                        BoardView(issues: filterIssues, issueCount: filterIssues.count, boardName: boards[i])
                    }
                    .frame(width: 380, height: 650)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

