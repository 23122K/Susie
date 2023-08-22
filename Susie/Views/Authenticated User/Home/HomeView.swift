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
            Spacer()
            Button("User info") {
                vm.userInfo()
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
