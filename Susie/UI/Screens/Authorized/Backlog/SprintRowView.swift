//
//  SprintRowView.swift
//  Susie
//
//  Created by Patryk Maciąg on 02/10/2023.
//

import SwiftUI

struct SprintRowView: View {
    let sprint: Sprint
    var body: some View {
        VStack(alignment: .listRowSeparatorLeading) {
            HStack {
                Text(sprint.name)
                    .foregroundColor(.susieWhitePrimary)
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.bottom, 5)
            
            HStack {
                Text("Issues - 123")
            }
            .padding(.bottom, 2)
            
            HStack {
                Text("Issues - 123")
            }
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.susieBluePriamry)
        }
    }
    
}

struct SprintRowView_Previews: PreviewProvider {
    static var previews: some View {
        SprintRowView(sprint: Sprint(name: "Test", projectID: 2))
    }
}
