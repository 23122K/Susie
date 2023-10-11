import SwiftUI
import SwipeActions

@MainActor
struct BacklogView: View {
    @StateObject private var backlog: BacklogViewModel
    @StateObject private var sprints: SprintsViewModel
    
    @State private var isPresented: Bool = false
    @State private var dropStatus: DropStatus = .exited
    
    var body: some View {
        GeometryReader { reader in
            NavigationStack {
                ScreenHeader(user: backlog.user, screenTitle: "Backlog", action: {
                    isPresented.toggle()
                }, content: {
                    Menu(content: {
                        Button("Create sprint") {}
                        Button("Create issue") {}
                    }, label: {
                        Image(systemName: "ellipsis")
                            .scaleEffect(1.1)
                    })
                })
                .padding(.top)
                .padding(.horizontal)
                
                if sprints.sprints.isEmpty {
                    NavigationLink(destination: {
                        SprintFormView()
                    }, label: {
                        CreateSprintView()
                            .padding(.top)
                    })
                } else {
                    Carousel(sprints.sprints, type: .unbounded) { sprint in
                        SprintRowView(sprint: sprint)
                            .onTapGesture { sprints.sprint = sprint }
                            .onDrop(of: [.text], delegate: SprintDropDelegate(sprints: sprints, dropStatus: $dropStatus, sprint: sprint))
                    }
                    .padding(.vertical)
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
                        .swipeMinimumDistance(5)
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
                
                Spacer()
            }
            .sheet(item: $backlog.issue) { issue in
                IssueDetailedView(issue: issue)
            }
            .navigationTitle("Backlog")
            .refreshable {
                backlog.fetch()
                sprints.fetch()
            }
            .onAppear {
                backlog.fetch()
                sprints.fetch()
            }
            .fullScreenCover(item: $sprints.sprint) { sprint in
                SprintView(sprints: sprints)
            }
        }
    }
    
    init(project: Project) {
        _backlog = StateObject(wrappedValue: BacklogViewModel(project: project))
        _sprints = StateObject(wrappedValue: SprintsViewModel(project: project))
    }
}

