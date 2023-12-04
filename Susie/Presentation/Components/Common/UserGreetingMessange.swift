//
//  UserGreetingMessange.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import SwiftUI

struct UserGreetingMessange: View {
    var body: some View {
        VStack{
            ZStack(alignment: .top) {
                Image("WelcomeImage")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.1)
            }
            
            ZStack(alignment: .center){
                VStack(alignment: .leading){
                    HStack{
                        Text(verbatim: "Be")
                        Text(verbatim: "agile.")
                            .foregroundColor(.susieBluePriamry)
                        Text(verbatim: "Get more done.")
                    }
                    .font(.title)
                    .bold()
                    .padding(.bottom, 5)
                    
                    Group{
                        Text(verbatim: "Get started today and see how")
                        +
                        Text(verbatim: " Susie")
                            .fontWeight(.bold)
                            .foregroundColor(.susieBluePriamry)
                        +
                        Text(verbatim: " can help you and your team achieve goals with ease.")
                    }
                    .font(.title3)
                    
                }
            }
            .padding(.horizontal)
            .offset(y: -10)
        }
    }
}

struct UserGreetingMessange_Previews: PreviewProvider {
    static var previews: some View {
        UserGreetingMessange()
    }
}
