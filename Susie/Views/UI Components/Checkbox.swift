//
//  Checkbox.swift
//  Scratchpad
//
//  Created by Patryk Maciąg on 03/05/2023.
//

import SwiftUI

struct boxView: View {
    @Binding var isChecked: Bool
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 4)
                .fill(isChecked ? .blue.opacity(0.6) : .gray.opacity(0.2))
            if(isChecked){
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.caption)
                    .bold()
            }
        }
        .frame(width: 16, height: 16)
    }
}

struct Checkbox: View {
    let title: String
    @Binding var isChecked: Bool
    var body: some View {
        ZStack(alignment: .leading) {
            HStack{
                HStack{
                    Text(title)
                        .foregroundColor(.blue.opacity(0.6))
                        .padding(.trailing, 5)
                    boxView(isChecked: $isChecked)
                    
                }
                .onTapGesture {
                    isChecked.toggle()
                }
                Spacer(minLength: 1)
            }
        }
    }
}

struct Checkbox_Previews: PreviewProvider {
    static var previews: some View {
        Checkbox(title: "Register as Scrum Master", isChecked: .constant(true))
    }
}
