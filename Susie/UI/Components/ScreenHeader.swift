//
//  ScreenHeader.swift
//  Justlift
//
//  Created by Patryk Maciąg on 14/09/2023.
//

import SwiftUI

struct ScreenHeader: View {
    let date: String
    let title: String
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            VStack(alignment: .leading) {
                Text(date)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .padding(.top)
        .navigationTitle(title)
        .toolbar(.hidden, for: .navigationBar)
    }
}

//struct ScreenHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ScreenHeader()
//    }
//}
