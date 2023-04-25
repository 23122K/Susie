//
//  TextButton.swift
//  Suzie
//
//  Created by Patryk Maciąg on 03/04/2023.
//

import SwiftUI

struct TextButton: View {
    var body: some View {
        ZStack{
            Group{
                Text("Forgot")
                    .foregroundColor(.black)
                +
                Text(" password")
                    .foregroundColor(.blue.opacity(0.7))
                    .bold()
                +
                Text("?")
            }
        }
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton()
    }
}
