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
                ProjectRowView(project: project)
                    .onTapGesture {
                        vm.fetchDetails(of: project)
                    }
                    .swipeActions {
                        Button("Delete") {
                            vm.delete(project: project)
                        }
                    }
            }
            .listStyle(.plain)
            .navigationTitle("Projects")
            .toolbar(.hidden, for: .navigationBar)
            
//            .navigationDestination(for: ProjectDTO.self) { project in
//                AuthenticatedUserView(project: project)
//            }

            Button("Create") {
                let rndm = Int.random(in: 0..<9999)
                vm.name = "Test_\(rndm)"
                vm.description = "Test"
                vm.createProject()
            }
        }
        .fullScreenCover(item: $vm.project) { project in
            AuthenticatedUserView(project: project)
        }
        .onAppear{ vm.fetch() }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
