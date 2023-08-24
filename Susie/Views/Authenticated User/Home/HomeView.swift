//
//  HomeView.swift
//  Susie
//
//  Created by Patryk Maciąg on 20/07/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: ClientViewModel
    var body: some View {
        VStack{
            LoggedPersonView()
            Button("User info") {
                vm.userInfo()
            }
            
            Button("Fetch projects") {
                vm.fetchProjects()
            }
            
            List(vm.projects) { project in
                Text(project.name)
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
