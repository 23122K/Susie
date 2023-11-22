//
//  ProjectsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 08/09/2023.
//

import SwiftUI
import SwipeActions

struct ProjectsView: View {
    @ObservedObject private var vm = ViewModel()
    @State private var isShown = false
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .lastTextBaseline) {
                ScreenHeader(user: vm.appStore.state.user, screenTitle: "Projects", action: {
                    isShown.toggle()
                }, content: {
                    NavigationLink(destination: {
                        ProjectFormView()
                            .onDisappear { vm.fetch() }
                    }, label: {
                        Image(systemName: "plus")
                            .scaleEffect(1.1)
                    })
                })
            }
            
            
            ScrollView {
                AsyncContentView(state: $vm.projects, { projects in
                    ForEach(projects) { project in
                        SwipeView(label: {
                            ProjectRowView(project: project)
                        }, leadingActions: { _ in
                            SwipeAction(action: {
                                vm.delete(project: project)
                            }, label: { _ in
                                HStack {
                                    Text("Delete")
                                        .fontWeight(.semibold)
                                    Image(systemName: "trash.fill")
                                }
                                .foregroundColor(Color.susieWhitePrimary)
                            }, background: { _ in
                                Color.red.opacity(0.95)
                            })
                            .allowSwipeToTrigger()
                            
                        })
                        .swipeSpacing(10)
                        .swipeMinimumDistance(10)
                        .swipeActionsStyle(.cascade)
                        .swipeActionsMaskCornerRadius(9)
                        .swipeActionCornerRadius(9)
                        .padding(.horizontal)
                        .onTapGesture { vm.project = project }
                }
                }, placeholder: ProjectPlaceholderView(), onAppear: {
                    vm.fetch()
                })
            }
            .refreshable {
                vm.fetch()
            }
        }
        .sideMenu(isPresented: $isShown, menuContent: {
            VStack(alignment: .leading) {
                HStack {
                    Text(vm.appStore.state.user?.fullName ?? "User full name")
                }
                
                Text("Settings")
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        })
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
