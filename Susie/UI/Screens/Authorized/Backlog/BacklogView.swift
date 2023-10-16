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
    @StateObject private var backlog: BacklogViewModel
    //    @StateObject private var sprints: SprintsViewModel
    
    @State private var dropStatus: DropStatus = .exited
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ScreenHeader(user: backlog.user, screenTitle: "Backlog", action: {
                isPresented.toggle()
            }, content: {
                Menu(content: {
                    NavigationLink("Crate sprint") {
                        SprintFormView(project: backlog.project)
                            .onDisappear{ backlog.fetch() }
                    }
                    
                    NavigationLink("Create issue") {
                        IssueFormView(project: backlog.project)
                            .onDisappear { backlog.fetch() }
                    }
                }, label: {
                    Image(systemName: "ellipsis")
                        .fontWeight(.bold)
                })
            })
            
            AsyncContentViewV2(state: $backlog.sprints, { sprints in
                if sprints.isEmpty {
                    NavigationLink(destination: {
                        SprintFormView(project: self.backlog.project)
                            .onDisappear{ self.backlog.fetch() }
                    }, label: { CreateSprintView() })
                } else {
                    Carousel(sprints, type: .unbounded) { sprint in
                        SprintRowView(sprint: sprint, status: $dropStatus)
                            .onTapGesture { self.backlog.sprint = sprint }
                            .onDrop(of: [.text], delegate: SprintDropDelegate(backlogViewModel: backlog, dropStatus: $dropStatus, sprint: sprint))
                    }
                }
            }, placeholder: SprintRowPlaceholderView() ,onAppear: {
                backlog.fetch()
            })
            .frame(height: 215)
            
            ScrollView(showsIndicators: false) {
                AsyncContentViewV2(state: $backlog.issues, { issues in
                    ForEach(issues) { issue in
                        SwipeView(label: {
                            IssueRowView(issue: issue)
                        }, leadingActions: { _ in
                            SwipeAction(action: {
                                backlog.delete(issue: issue)
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
                                backlog.edit(issue: issue)
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
                            backlog.draggedIssue = issue
                            return NSItemProvider()
                        }
                        .onTapGesture {
                            backlog.issue = issue
                        }
                    }
                    
                }, placeholder: IssuePlaceholderView())
                NavigationLink("Create issue", destination: {
                    IssueFormView(project: backlog.project)
                })
                .buttonStyle(.issueCreation)
                .offset(y: -15)
            }
        }
        .refreshable {
            backlog.fetch()
        }
            
        .navigationTitle("Backlog")
        .fullScreenCover(item: $backlog.sprint) { sprint in
            SprintView(sprint: sprint, project: backlog.project)
                .onDisappear{ backlog.fetch() }
        }
        .sheet(item: $backlog.issue) { issue in
            IssueDetailsView(issue: issue)
        }
        
    }
    
    init(project: ProjectDTO) {
        _backlog = StateObject(wrappedValue: BacklogViewModel(project: project))
//        _sprints = StateObject(wrappedValue: SprintsViewModel(project: project))
    }
}

