//
//  ProjectsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject private var projectViewModel = ProjectViewModel()
    var body: some View {
        VStack {
            ForEach(projectViewModel.client.projectsDTOs) { project in
                ProjectRowView(project: project)
            }
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
