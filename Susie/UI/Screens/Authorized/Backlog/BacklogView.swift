import SwiftUI
import SwipeActions

extension MutableCollection {
    mutating func move(fromOffsets source: IndexSet,toOffset destination: Int) {}
}

@MainActor
struct BacklogView: View {
    @StateObject private var backlog: BacklogViewModel
    @StateObject private var sprints: SprintsViewModel
    
    @State private var isPresented: Bool = false
    @State private var dropStatus: DropStatus = .exited
    
    private func refresh() {
        sprints.fetch()
        backlog.fetch()
    }
    
    var body: some View {
        NavigationStack {
            ScreenHeader(user: backlog.user, screenTitle: "Backlog", action: {
                isPresented.toggle()
            }, content: {
                Menu(content: {
                    NavigationLink("Crate sprint") {
                        SprintFormView(project: backlog.project)
                            .onDisappear{ refresh() }
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
            
            if sprints.sprints.isEmpty {
                NavigationLink(destination: {
                    SprintFormView(project: backlog.project)
                }, label: {
                    CreateSprintView()
                        .padding(.top)
                })
            } else {
                Carousel(sprints.sprints, type: .unbounded) { sprint in
                    SprintRowView(sprint: sprint, status: $dropStatus)
                        .onTapGesture { sprints.sprint = sprint }
                        .onDrop(of: [.text], delegate: SprintDropDelegate(sprints: sprints, dropStatus: $dropStatus, sprint: sprint))
                }
            }
            
            ScrollView(showsIndicators: false) {
                ForEach(backlog.issues) { issue in
                    SwipeView(label: {
                        IssueRowView(issue: issue)
                            .onDrag {
                                sprints.issue = issue
                                return NSItemProvider()
                            }
                            .onTapGesture {
                                backlog.details(of: issue)
                            }
                    }, leadingActions: { _ in
                        SwipeAction(action: {
                            print("Deleted")
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
                            print("Edited")
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
                }
                
                NavigationLink("Create issue", destination: {
                    IssueFormView(project: backlog.project)
                })
                .buttonStyle(.issueCreation)
                .offset(y: -15)
            }
            .onAppear {
                backlog.fetch()
                sprints.fetch()
            }
            .refreshable {
                backlog.fetch()
                sprints.fetch()
            }
            
        }
        .sheet(item: $backlog.issue) { issue in
            IssueDetailedView(issue: issue)
        }
        .navigationTitle("Backlog")
        .fullScreenCover(item: $sprints.sprint) { sprint in
            SprintView(sprints: sprints)
        }
    }
    
    init(project: Project) {
        _backlog = StateObject(wrappedValue: BacklogViewModel(project: project))
        _sprints = StateObject(wrappedValue: SprintsViewModel(project: project))
    }
}

