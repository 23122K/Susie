//
//  SprintRowView.swift
//  Susie
//
//  Created by Patryk Maciąg on 02/10/2023.
//

import SwiftUI

struct SprintRowView: View {
    let sprint: Sprint
    @Binding var status: DropStatus
    
    var body: some View {
        GeometryReader { reader in
            HStack {
                VStack(alignment: .leading) {
                    Text(sprint.name)
                        .font(.title)
                    
                }
                .padding()
                Spacer()
            }
            .frame(width: reader.size.width, height: 200)
            .fontWeight(.semibold)
            .foregroundColor(Color.susieWhitePrimary)
            .background(status == .entered ? Color.susieBluePriamry:  Color.susieBlueSecondary)
            .cornerRadius(9)
        }
        .padding()
    }
    
}

//struct SprintRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        SprintRowView(sprint: Sprint(name: "Test", projectID: 2))
//    }
//}
