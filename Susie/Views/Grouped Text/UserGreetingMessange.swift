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
                        Text("Be")
                        Text("agile.")
                            .foregroundColor(.blue)
                            .opacity(0.6)
                        Text("Get more done.")
                    }
                    .font(.title)
                    .bold()
                    .padding(.bottom, 5)
                    
                    Group{
                        Text("Get started today and see how")
                        +
                        Text(" Susie")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        +
                        Text(" can help you and your team achieve goals with ease.")
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
