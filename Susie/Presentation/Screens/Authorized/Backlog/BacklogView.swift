import SwiftUI

@MainActor
struct BacklogView: View {
    @ObservedObject private var vm: BacklogViewModel
    
    var body: some View {
        NavigationStack {
            ScreenHeader(user: vm.user, screenTitle: "Backlog") {
                Menu(content: {
                    NavigationLink("Create sprint") {
                        SprintFormView(project: vm.project.toDTO())
                    }
               
                    NavigationLink("Create issue") {
                        IssueFormView(project: vm.project.toDTO())
                    }
                    
                }, label: { Image(systemName: "ellipsis").fontWeight(.bold) })
            }
            
            AsyncContentView(state: $vm.sprints, { sprints in
                switch sprints.isEmpty {
                case true:
                    NavigationLink(destination: {
                        SprintFormView(project: vm.project.toDTO())
                    }, label: { CreateSprintView() })
                case false:
                    Carousel(sprints, type: .unbounded) { sprint in
                        SprintRowView(sprint: sprint, status: $vm.dropStatus)
                            .onTapGesture { vm.sprint = sprint }
                            .onDrop(of: [.text], delegate: SprintDropDelegate(vm: vm, sprint: sprint))
                    }
                }
            }, placeholder: SprintRowPlaceholderView())
            .frame(height: 215)
            
            ScrollView {
                AsyncContentView(state: $vm.issues, { issues in
                    ForEach(issues) { issue in
                        SwipeContent {
                            IssueRowView(issue: issue)
                        } onDelete: {
                            vm.deleteIssueButtonTapped(issue: issue)
                        } onEdit: {
                            vm.issue = issue
                        }
                        .onDrag{ vm.onDragIssueGesture(issue: issue) }
                    }
                }, placeholder: IssuePlaceholderView())
                
                NavigationLink("Create issue", destination: {
                    IssueFormView(project: vm.project.toDTO())
                })
                .buttonStyle(.issueCreation)
                .offset(y: -15)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("Backlog")
        .onAppear { 
            print("Executed")
            vm.fetchInactiveSprintsAndIssues() }
        .refreshable { vm.fetchInactiveSprintsAndIssues() }
    }
    
    init(project: Project, user: User) { self._vm = ObservedObject(initialValue: BacklogViewModel(project: project, user: user)) }
}

//struct BacklogView: View {
//    @ObservedObject private var vm: BacklogViewModel
//    
//    @State private var dropStatus: DropStatus = .exited
//    @State private var isPresented: Bool = false
//    
//    var body: some View {
//        NavigationStack {
//            ScreenHeader(user: vm.appStore.state.user, screenTitle: "Backlog", action: {
//                isPresented.toggle()
//            }, content: {
//                Menu(content: {
//                    NavigationLink("Crate sprint") {
//                        //TODO: Fix
//                        SprintFormView(project: vm.appStore.state.project?.toDTO()!)
//                            .onDisappear{ vm.fetch() }
//                    }
//                    
//                    NavigationLink("Create issue") {
//                        IssueFormView(project: vm.project)
//                            .onDisappear { vm.fetch() }
//                    }
//                }, label: {
//                    Image(systemName: "ellipsis")
//                        .fontWeight(.bold)
//                })
//            })
//            
//            AsyncContentView(state: $vm.sprints, { sprints in
//                if sprints.isEmpty {
//                    NavigationLink(destination: {
//                        SprintFormView(project: self.vm.project)
//                            .onDisappear{ self.vm.fetch() }
//                    }, label: { CreateSprintView() })
//                } else {
//                    Carousel(sprints, type: .unbounded) { sprint in
//                        SprintRowView(sprint: sprint, status: $dropStatus)
//                            .onTapGesture { self.vm.sprint = sprint }
//                            .onDrop(of: [.text], delegate: SprintDropDelegate(backlogViewModel: vm, dropStatus: $dropStatus, sprint: sprint))
//                    }
//                }
//            }, placeholder: SprintRowPlaceholderView() ,onAppear: {
//                vm.fetch()
//            })
//            .frame(height: 215)
//            
//            ScrollView(showsIndicators: false) {
//                AsyncContentView(state: $vm.issues, { issues in
//                    ForEach(issues) { issue in
//                        SwipeView(label: {
//                            IssueRowView(issue: issue)
//                        }, leadingActions: {
//                            vm.deleteIssueButtonTapped(issue: issue)
//                        }, trailingActions: {
//                            vm.issue = issue
//                        })
//                        .onDrag {
//                            vm.draggedIssue = issue
//                            return NSItemProvider()
//                        }
//                        .onTapGesture {
//                            vm.issue = issue
//                        }
//                    }
//                }, placeholder: IssuePlaceholderView())
//                
//                NavigationLink("Create issue", destination: {
//                    IssueFormView(project: vm.project)
//                        .onDisappear{ vm.fetch() }
//                })
//                .buttonStyle(.issueCreation)
//                .offset(y: -15)
//            }
//        }
//        .refreshable {
//            vm.fetch()
//        }
//            
//        .navigationTitle("Backlog")
//        .fullScreenCover(item: $vm.sprint) { sprint in
//            SprintView(sprint: sprint, project: vm.project)
//                .onDisappear{ vm.fetch() }
//        }
//        .fullScreenCover(item: $vm.issue) { issue in
//            IssueDetailsView(issue: issue)
//        }
//    }
//    
//    init() {
//        _vm = ObservedObject(initialValue: BacklogViewModel())
//    }
//}
//
