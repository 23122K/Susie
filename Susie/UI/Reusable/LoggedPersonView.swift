//
//  LoggedPersonView.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/04/2023.
//

import SwiftUI

struct LoggedPersonView: View {
    let firstName: String = "Patryk"
    let lastName: String = "Maciąg"
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .trailing){
            HStack{
                Text("\(firstName) \(lastName)")
                    .font(.headline)
                    .bold()
                    .padding(.horizontal, 10)
                AssignedPersonView(initials: "PM", size: 40)
                    .onTapGesture(perform: {
                        isPresented.toggle()
                    })
                    .sheet(isPresented: $isPresented, content: {
                        UserAccountView()
                            .presentationDetents([.medium])
                    })
            }
        }
        .frame(height: 40)
        .offset(x: 90)
    }
}

struct LoggedPersonView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedPersonView()
    }
}
