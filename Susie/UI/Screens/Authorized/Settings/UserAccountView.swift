//
//  UserAccountView().swift
//  Susie
//
//  Created by Patryk Maciąg on 07/04/2023.
//

import SwiftUI

struct UserAccountView: View {
    var body: some View {
        VStack{
            Button("Log out") {
                print("Logged out")
            }
        }
    }
}

struct UserAccountView_Previews: PreviewProvider {
    static var previews: some View {
        UserAccountView()
            .environmentObject(ClientViewModel())
    }
}
