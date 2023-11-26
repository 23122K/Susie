//
//  BoardsView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardsView: View {
    @ObservedObject private var vm: BoardsViewModel
    
    var body: some View {
        NavigationStack{
            ScreenHeader(user: vm.user, screenTitle: vm.sprint?.name ?? "Boards") {
                Menu(content: {
                    Button(role: .destructive, action: {
                        vm.stopSprintButtonTapped()
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
            }
            
            GeometryReader { reader in
                TabView {
                    ForEach(IssueStatus.allCases, id: \.rawValue) { status in
                        AsyncContentView(state: $vm.issues, { issues in
                            BoardView(issues: issues, status: status)
                                .frame(width: reader.size.width, height: reader.size.height)
                        }, placeholder: BoardPlaceholderView())
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .task { vm.fetchIssuesAssignedToActiveSprint() }
        .refreshable { vm.fetchIssuesAssignedToActiveSprint() }
    }
    
    init(project: Project, user: User) { self._vm = ObservedObject(initialValue: BoardsViewModel(project: project, user: user)) }
    
    
}

