//
//  UserAccountView().swift
//  Susie
//
//  Created by Patryk Maciąg on 07/04/2023.
//

import SwiftUI

struct UserAccountView: View {
    @EnvironmentObject var logic: Logic
    var body: some View {
        VStack{
            Button("Fetch tasks") {
                logic.fetchTasks()
            }
            
            Button("Log out") {
                logic.model.signOut()
            }
            
            List(logic.tasks) { task in
                Text(task.title)
            }
        }
    }
}

struct UserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView()
            .environmentObject(Logic())
    }
}
