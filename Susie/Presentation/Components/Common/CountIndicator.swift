//
//  CountIndicator.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/12/2023.
//

import SwiftUI

struct CountIndicator: View {
    let count: Int
    let backgorundColor: Color
    let foregorundColor: Color
    
    var body: some View {
        VStack{
            Text(verbatim: count.description)
                .fontWeight(.bold)
                .foregroundColor(foregorundColor)
                .padding(5)
                .background{
                    RoundedRectangle(cornerRadius: 5)
                        .fill(backgorundColor)
                        .frame(width: 25, height: 25)
                }
                .padding(.horizontal,5)
        }
    }
}
