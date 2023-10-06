//
//  BoardsView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardsView: View {
    @State var isPresented: Bool = false
    @StateObject var boards: BoardsViewModel
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0){
            HStack(alignment: .lastTextBaseline) {
                ScreenHeader(user: boards.user, screenTitle: "Projects", content: {
                    NavigationLink("+", destination: {
                        ProjectView()
                    })
                })
                .onTapGesture {
//                    isShown.toggle()
                }
            }
            .padding(.horizontal)
            
            TabView {
                ForEach(boards.statuses) { status in
                    GeometryReader { g in
                        BoardView(issues: boards.issues, status: status)
                    }
                    .frame(width: 380, height: 650)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            Button("Create issue") {
                isPresented.toggle()
            }
        }
        .onAppear { boards.refresh() }
        .refreshable { boards.refresh() }
        .sheet(isPresented: $isPresented) {
            IssueFormView(project: boards.project)
                .onDisappear {
                    boards.refresh()
                }
        }
    }
    
    init(project: Project) {
        _boards = StateObject(wrappedValue: BoardsViewModel(project: project))
    }
    
    
}

