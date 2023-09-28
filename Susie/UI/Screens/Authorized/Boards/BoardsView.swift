//
//  BoardsView.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct BoardsView: View {
    @State var isPresented: Bool = false
    @StateObject var vm: BoardsViewModel
    var body: some View {
        VStack(alignment: .trailing){
            TabView {
                ForEach(vm.statuses) { status in
                    GeometryReader { g in
                        BoardView(issues: vm.issues, status: status)
                    }
                    .frame(width: 380, height: 650)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            Button("Create issue") {
                isPresented.toggle()
            }
        }
        .sheet(isPresented: $isPresented) {
            IssueFormView(project: vm.project)
        }
    }
    
    init(project: Project) {
        _vm = StateObject(wrappedValue: BoardsViewModel(project: project))
    }
    
    
}

