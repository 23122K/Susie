//
//  ProjectsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject private var vm = ProjectsViewModel()
    @State private var isShown = false
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .lastTextBaseline) {
                ScreenHeader(user: vm.user, screenTitle: "Projects", content: {
                    NavigationLink("+", destination: {
                        ProjectView()
                    })
                })
                .onTapGesture {
                    isShown.toggle()
                }
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
                        .tint(.red.opacity(0.25))
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
        .sideMenu(isPresented: $isShown, menuContent: {
            VStack(alignment: .leading) {
                HStack {
                    Text(vm.user?.fullName ?? "User full name")
                }
                
                Text("Settings")
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        })
        .refreshable {
            vm.fetch()
        }
        .onAppear {
            vm.fetch()
        }
        .fullScreenCover(item: $vm.project) { project in
            AuthenticatedUserView(project: project)
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
