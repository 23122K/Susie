//
//  TextFieldModifier.swift
//  Susie
//
//  Created by Patryk Maciąg on 13/10/2023.
//

import SwiftUI

struct SusieTextField: TextFieldStyle {
    private let main: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(main ? .title : .body)
//            .fontWeight(.semibold)
            .autocapitalization(.sentences)
            .autocorrectionDisabled()
            .keyboardType(.default)
            .frame(height: 50)
            .foregroundColor(main ? .susieBluePriamry : .gray)
    }
    
    init(main: Bool) {
        self.main = main
    }
}

extension TextFieldStyle where Self == SusieTextField  {
    static var susiePrimaryTextField: Self {
        return .init(main: true)
    }
    
    static var susieSecondaryTextField: Self {
        return .init(main: false)
    }
}
