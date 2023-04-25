//
//  AuthenticatedUserView.swift
//  Susie
//
//  Created by Patryk Maciąg on 04/04/2023.
//

import SwiftUI

struct AuthenticatedUserView: View {
    var body: some View {
        LoggedPersonView()
        TabView{
            BoardsView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Board")
                }
            SprintView()
                .tabItem{
                    Image(systemName: "person.3.fill")
                    Text("Reports")
                }
            BacklogsView()
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Backlog")
                }
            //HomeView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Account")
                }
        }
    }
}

struct AuthenticatedUserView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedUserView()
    }
}
