//
//  ProjectRowView.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI

struct ProjectRowView: View {
    var project: ProjectDTO
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) { Spacer(minLength: 1) } //Makes view take all the space
            Text(project.name)
                .font(.headline)
            Text(project.description)
                .font(.callout)
                .lineLimit(1)
                .padding(.bottom, 5)
                
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 9)
                .fill(Color.susieWhiteSecondary)
        }
    }
}
