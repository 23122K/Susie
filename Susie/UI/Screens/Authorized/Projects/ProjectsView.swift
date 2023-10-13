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
                ScreenHeader(user: vm.user, screenTitle: "Projects", action: {
                    isShown.toggle()
                }, content: {
                    NavigationLink(destination: {
                        ProjectFormView()
                            .onAppear{
                                print("Appeared")
                            }
                            .onDisappear {
                                print("Should fetch")
                                vm.fetch()
                            }
                    }, label: {
                        Image(systemName: "plus")
                            .scaleEffect(1.1)
                    })
                })
            }
            .padding()
            
            ScrollView {
                ForEach(vm.projects) { project in
                    ProjectRowView(project: project)
                        .onTapGesture {
                            vm.details(of: project)
                        }
                        .padding(.horizontal)
                }
            }
            .refreshable {
                vm.fetch()
            }
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
