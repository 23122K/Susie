////
////  HomeView.swift
////  Susie
////
////  Created by Patryk Maciąg on 20/07/2023.
////
//
//import SwiftUI
//import Factory
//
//struct HomeView: View {
//    @Injected(\.client) var client
//    var body: some View {
//        VStack{
//            Button("User info") { vm.userInfo() }
//            Button("Create project") {
//                let int = Int.random(in: 0..<999)
//                print(int)
//                let project = ProjectDTO(name: "Test_\(int)", description: "\(int)")
//                vm.createProject(with: project)
//            }
//            Button("Fetch projects") { vm.fetchProjects() }
//            Divider()
//            List(vm.projectDTOs) { project in
//                Text(project.name)
//                Button("Fetch details") {
//                    vm.fetchDetails(of: project)
//                }
//
//                Button("Delete project") {
//                    vm.delete(project: project)
//                }
//
//                Button("Update project") {
//                    let newDetails = ProjectDTO(name: "Updated name", description: "XD")
//                    vm.updateProject(with: newDetails)
//                }
//
//                Divider()
//            }
//            Divider()
//            List(vm.projects) { project in
//                Text(project.name)
//            }
//        }
//    }
//}
//
////struct HomeView_Previews: PreviewProvider {
////    static var previews: some View {
////        HomeView()
////    }
////}
