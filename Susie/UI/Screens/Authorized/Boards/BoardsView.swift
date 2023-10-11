//
//  BoardsView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardsView: View {
    @StateObject private var boards: BoardsViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack{
            ScreenHeader(user: boards.user, screenTitle: "Backlog", action: {
                isPresented.toggle()
            }, content: {
                Menu(content: {
                    Button("Create sprint") {}
                    Button("Create issue") {}
                }, label: {
                    Image(systemName: "ellipsis")
                        .scaleEffect(1.1)
                })
            })
            .padding(.top)
            .padding(.horizontal)
            
            TabView {
                ForEach(IssueStatus.allCases, id: \.rawValue) { status in
                    GeometryReader { g in
                        BoardView(issues: boards.issues, status: status)
                    }
                    .frame(width: 380, height: 650)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .onAppear { boards.refresh() }
        .refreshable { boards.refresh() }
    }
    
    init(project: Project) {
        _boards = StateObject(wrappedValue: BoardsViewModel(project: project))
    }
    
    
}

