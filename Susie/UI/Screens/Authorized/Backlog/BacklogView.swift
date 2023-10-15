import SwiftUI
import SwipeActions

struct SprintsView: View {
    @ObservedObject var sprintsViewModel: SprintsViewModel
    @Binding var dropStatus: DropStatus
    
    var body: some View {
        AsyncContentView(source: sprintsViewModel) { sprints in
            if sprints.isEmpty {
                NavigationLink(destination: {
                    SprintFormView()
                }, label: { CreateSprintView() })
            } else {
                Carousel(sprints, type: .unbounded) { sprint in
                    SprintRowView(sprint: sprint, status: $dropStatus)
                        .onTapGesture { sprintsViewModel.sprint = sprint }
                        .onDrop(of: [.text], delegate: SprintDropDelegate(sprints: sprintsViewModel, dropStatus: $dropStatus, sprint: sprint))
                }
            }
        }
    }
}



@MainActor
struct BacklogView: View {
    @StateObject private var backlog: BacklogViewModel
    @StateObject private var sprints: SprintsViewModel
    
    @State private var dropStatus: DropStatus = .exited
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ScreenHeader(user: backlog.user, screenTitle: "Backlog", action: {
                isPresented.toggle()
            }, content: {
                Menu(content: {
                    NavigationLink("Crate sprint") {
                        SprintFormView()
                            .onDisappear{ backlog.fetch() }
                    }
                    
                    NavigationLink("Create issue") {
                        IssueFormView(project: backlog.project)
                            .onDisappear { backlog.fetch(); print("XD") }
                    }
                }, label: {
                    Image(systemName: "ellipsis")
                        .fontWeight(.bold)
                })
            })
            
            SprintsView(sprintsViewModel: sprints, dropStatus: $dropStatus)
            
            ScrollView(showsIndicators: false) {
                AsyncContentView(source: backlog) { issues in
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
                            sprints.issue = issue
                            return NSItemProvider()
                        }
                        .onTapGesture {
                            backlog.issue = issue
                        }
                    }
                }
                
                NavigationLink("Create issue", destination: {
                    IssueFormView(project: backlog.project)
                })
                .buttonStyle(.issueCreation)
                .offset(y: -15)
                
            }
            .refreshable {
                backlog.fetch()
            }
            
        }
        .navigationTitle("Backlog")
        .fullScreenCover(item: $sprints.sprint) { sprint in
            SprintView(sprint: sprint, project: sprints.project)
                .onDisappear{ backlog.fetch() }
        }
        .sheet(item: $backlog.issue) { issue in
            IssueDetailsView(issue: issue)
        }
        
    }
    
    init(project: Project) {
        _backlog = StateObject(wrappedValue: BacklogViewModel(project: project))
        _sprints = StateObject(wrappedValue: SprintsViewModel(project: project))
    }
}
    
