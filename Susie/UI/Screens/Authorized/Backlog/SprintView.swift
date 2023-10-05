//
//  SprintView.swift
//  Susie
//
//  Created by Patryk Maciąg on 30/09/2023.
//

import SwiftUI

struct SprintView: View {
    @StateObject private var sprint: SprintViewModel
    var body: some View {
        VStack {
            Text(sprint.name)
        }
    }
    
    init(sprint: Sprint) {
        _sprint = StateObject(wrappedValue: SprintViewModel(sprint: sprint))
    }
}

//struct SprintView_Previews: PreviewProvider {
//    static var previews: some View {
//        SprintView()
//    }
//}
