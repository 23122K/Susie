//
//  ProjectsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject private var vm = ProjectsViewModel()
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .lastTextBaseline) {
                ScreenHeader(date: "29.09.2023", title: "Projects")
                Spacer()
                NavigationLink(destination: {
                    ProjectView()
                }, label: {
                    Text("Add project")
                        .fontWeight(.semibold)
                })
            }
            .padding(.horizontal)
            
            List(vm.projects) { project in
                ProjectRowView(project: project)
                    .onTapGesture {
                        vm.fetchDetails(of: project)
                    }
                    .swipeActions {
                        Button("Delete") {
                            vm.delete(project: project)
                        }
                        .tint(.red.opacity(0.6))
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        NavigationLink(destination: {
                            ProjectView(project: project)
                        }, label: {
                            Text("Edit")
                        })
                        .tint(Color.susieBluePriamry)
                    }
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .refreshable {
            vm.fetch()
        }
        .fullScreenCover(item: $vm.project) { project in
            AuthenticatedUserView(project: project)
        }
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            Button("XD") {
                
            }
            NavigationLink(destination: {
                ProjectView()
            }, label: {
                Text("Add")
            })
        }
        .onAppear{
            print("fetch")
            vm.fetch()
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
