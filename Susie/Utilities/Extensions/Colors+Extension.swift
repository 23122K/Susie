//
//  Colors+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/09/2023.
//

import SwiftUI

extension Color {
    static let susieBluePriamry = Color("susieBluePrimary")
    static let susieBlueSecondary = Color("susieBlueSecondary")
    static let susieBlueTertiary = Color("susieBlueTertiary")
    static let susieWhitePrimary = Color("susieWhitePrimary")
    static let susieWhiteSecondary = Color("susieWhiteSecondary")
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: Self {
        return .init()
    }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: Self {
        return .init()
    }
}
