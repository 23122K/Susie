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
            ScreenHeader(user: boards.user, screenTitle: boards.sprint?.name ?? "Backlog", action: {
                isPresented.toggle()
            }, content: {
                Menu(content: {
                    Button(role: .destructive, action: {
                        boards.stop()
                    }, label: {
                        Text("Stop sprint")
                            .foregroundColor(.red)
                        Image(systemName: "pause.fill")
                            .foregroundStyle(.red)
                    })
                }, label: {
                    Image(systemName: "ellipsis")
                        .scaleEffect(1.1)
                })
            })
            
            GeometryReader { reader in
                TabView {
                    ForEach(IssueStatus.allCases, id: \.rawValue) { status in
                        AsyncContentView(state: $boards.state, { issues in
                            BoardView(issues: issues, status: status)
                                .frame(width: reader.size.width, height: reader.size.height)
                        }, placeholder: BoardPlaceholderView(), onAppear: {
                            boards.fetch()
                        })
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .refreshable { boards.fetch() }
    }
    
    init(project: ProjectDTO) {
        _boards = StateObject(wrappedValue: BoardsViewModel(project: project))
    }
    
    
}

