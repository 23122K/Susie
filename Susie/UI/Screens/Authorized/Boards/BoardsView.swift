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
            
            AsyncContentView(source: boards) { issues in
                TabView {
                    ForEach(IssueStatus.allCases, id: \.rawValue) { status in
                        GeometryReader { g in
                            BoardView(issues: issues, status: status)
                        }
                        .frame(width: 380, height: 650)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .refreshable { boards.fetch() }
    }
    
    init(project: Project) {
        _boards = StateObject(wrappedValue: BoardsViewModel(project: project))
    }
    
    
}

