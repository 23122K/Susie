//
//  HomeView.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/07/2023.
//

import SwiftUI
import Factory

struct HomeView: View {
    @StateObject private var home: HomeViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
           ScreenHeader(user: home.user, screenTitle: "Home", action: {
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
            
            Spacer()
        }
    }
    
    init(project: Project) {
        _home = StateObject(wrappedValue: HomeViewModel(project: project))
    }
}
