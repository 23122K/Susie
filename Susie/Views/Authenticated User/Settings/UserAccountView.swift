//
//  UserAccountView().swift
//  Susie
//
//  Created by Patryk Maciąg on 07/04/2023.
//

import SwiftUI

struct UserAccountView: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        VStack{
            Button("Fetch issues") {
                vm.fetchIssues()
            }
            
            Button("Log out") {
                vm.model.signOut()
            }
            
            List(vm.issues) { issue in
                Text(issue.title)
            }
        }
    }
}

struct UserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView()
            .environmentObject(ViewModel())
    }
}
