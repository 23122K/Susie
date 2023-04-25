//
//  SprintView.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/04/2023.
//

import SwiftUI

struct SprintView: View {
    let sprintName: String = "Ofscpace "
    let startDate: String = "23 March"
    let endData: String = "11 April"
    var body: some View {
        ZStack(alignment: .topLeading){
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(.white)
                .frame(width: 350, height: 350)
                .shadow(color: Color.gray.opacity(0.7), radius: 16)
            VStack{
                Text("\(sprintName) project")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 1)
                HStack{
                    Image(systemName: "calendar")
                    Text("\(startDate) - \(endData)")
                }
                .padding(.bottom, 4)
                Text("\(sprintName) project")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 2)
                
                ZStack(alignment: .center){
                    Circle()
                    
                    Circle()
                        .trim(from: 0.5, to: 1)
                        .stroke(lineWidth: 20)
                        .frame(width: 200, height: 200)
                }
                
            }
            .padding()
        }
        .padding()
    }
}

struct SprintView_Previews: PreviewProvider {
    static var previews: some View {
        SprintView()
    }
}
