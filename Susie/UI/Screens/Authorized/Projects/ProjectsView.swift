//
//  ProjectsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject private var vm = ProjectViewModel()
    
    var body: some View {
        NavigationStack {
            List(vm.projectsDTOs) { project in
                NavigationLink(value: project) {
                    ProjectRowView(project: project)
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                }
                .swipeActions {
                    Button("Delete") {
                        vm.delete(project: project)
                    }
                }
            }
            .navigationTitle("Projects")
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: ProjectDTO.self) { _ in
                AuthenticatedUserView()
            }
            
            Button("Create") {
                let rndm = Int.random(in: 0..<9999)
                vm.name = "Test_\(rndm)"
                vm.description = "Test"
                vm.createProject()
            }
        }
        .onAppear{ vm.fetch() }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
