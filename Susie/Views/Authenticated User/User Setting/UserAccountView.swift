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
            Button("Fetch tasks") {
                vm.fetchTasks()
            }
            
            Button("Log out") {
                vm.model.signOut()
            }
            
            List(vm.tasks) { task in
                Text(task.title)
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
