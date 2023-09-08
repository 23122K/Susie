//
//  PrimaryButton.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/09/2023.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment (\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            configuration.label
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(!isEnabled ? Color.susieBlueSecondary : (configuration.isPressed ? Color.susieBlueSecondary : Color.susieBluePriamry))
                .cornerRadius(25)
//                .shadow(color: Color.gray.opacity(0.3), radius: 16)
        }
        .padding(.horizontal, 20)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    @Environment (\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            configuration.label
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isEnabled ? (configuration.isPressed ? Color.susieBlueSecondary : Color.susieBluePriamry) : Color.susieBlueTertiary )
                .cornerRadius(25)
//                .shadow(color: Color.gray.opacity(0.3), radius: 16)
        }
        .padding(.horizontal, 50)
    }
}
