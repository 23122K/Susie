import SwiftUI
import SwipeActions

//struct SprintsView: View {
//    @ObservedObject var sprintsViewModel: SprintsViewModel
//    @Binding var dropStatus: DropStatus
//
//    var body: some View {
//    }
//}
//


@MainActor
struct BacklogView: View {
    @StateObject private var vm: BacklogViewModel
    
    @State private var dropStatus: DropStatus = .exited
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ScreenHeader(user: vm.user, screenTitle: "Backlog", action: {
                isPresented.toggle()
            }, content: {
                Menu(content: {
                    NavigationLink("Crate sprint") {
                        SprintFormView(project: vm.project)
                            .onDisappear{ vm.fetch() }
                    }
                    
                    NavigationLink("Create issue") {
                        IssueFormView(project: vm.project)
                            .onDisappear { vm.fetch() }
                    }
                }, label: {
                    Image(systemName: "ellipsis")
                        .fontWeight(.bold)
                })
            })
            
            AsyncContentView(state: $vm.sprints, { sprints in
                if sprints.isEmpty {
                    NavigationLink(destination: {
                        SprintFormView(project: self.vm.project)
                            .onDisappear{ self.vm.fetch() }
                    }, label: { CreateSprintView() })
                } else {
                    Carousel(sprints, type: .unbounded) { sprint in
                        SprintRowView(sprint: sprint, status: $dropStatus)
                            .onTapGesture { self.vm.sprint = sprint }
                            .onDrop(of: [.text], delegate: SprintDropDelegate(backlogViewModel: vm, dropStatus: $dropStatus, sprint: sprint))
                    }
                }
            }, placeholder: SprintRowPlaceholderView() ,onAppear: {
                vm.fetch()
            })
            .frame(height: 215)
            
            ScrollView(showsIndicators: false) {
                AsyncContentView(state: $vm.issues, { issues in
                    ForEach(issues) { issue in
                        SwipeView(label: {
                            IssueRowView(issue: issue)
                        }, leadingActions: { _ in
                            SwipeAction(action: {
                                vm.delete(issue: issue)
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
                            
                        }, trailingActions: { _ in
                            SwipeAction(action: {
                                vm.issue = issue
                            }, label: { _ in
                                HStack {
                                    Text("Edit")
                                    Image(systemName: "pencil")
                                }
                                .fontWeight(.semibold)
                                .foregroundColor(Color.susieWhitePrimary)
                            }, background: { _ in
                                Color.susieBluePriamry
                            })
                            .allowSwipeToTrigger()
                        })
                        .swipeSpacing(10)
                        .swipeMinimumDistance(10)
                        .swipeActionsStyle(.cascade)
                        .swipeActionsMaskCornerRadius(9)
                        .swipeActionCornerRadius(9)
                        .padding(.horizontal)
                        .onDrag {
                            vm.draggedIssue = issue
                            return NSItemProvider()
                        }
                        .onTapGesture {
                            vm.issue = issue
                        }
                    }
                    
                }, placeholder: IssuePlaceholderView())
                NavigationLink("Create issue", destination: {
                    IssueFormView(project: vm.project)
                        .onDisappear{ vm.fetch() }
                })
                .buttonStyle(.issueCreation)
                .offset(y: -15)
            }
        }
        .refreshable {
            vm.fetch()
        }
            
        .navigationTitle("Backlog")
        .fullScreenCover(item: $vm.sprint) { sprint in
            SprintView(sprint: sprint, project: vm.project)
                .onDisappear{ vm.fetch() }
        }
        .fullScreenCover(item: $vm.issue) { issue in
            IssueDetailsView(issue: issue)
        }
    }
    
    init(project: ProjectDTO) {
        _vm = StateObject(wrappedValue: BacklogViewModel(project: project))
    }
}

