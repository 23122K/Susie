//
//  GroupedTermsOfCondition.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import SwiftUI

struct TermsOfService: View {
    var body: some View {
        Group{
            Text("By signing up, you agree to our")
            +
            Text(" Terms of Service")
                .foregroundColor(.susieBluePriamry
                )
            +
            Text(",")
            +
            Text(" Privacy ")
                .foregroundColor(.susieBluePriamry)
            +
            Text("and ")
            +
            Text("Cookie Use")
                .foregroundColor(.susieBluePriamry)
        }
        .font(.caption)
        .padding(.horizontal, 33)
    }
}

struct TermsOfService_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfService()
    }
}
