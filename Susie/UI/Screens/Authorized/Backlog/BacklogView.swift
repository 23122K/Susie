import SwiftUI

@MainActor
struct BacklogView: View {
    @StateObject private var backlog: BacklogViewModel
    @StateObject private var sprints: SprintsViewModel
    @State private var dropStatus: DropStatus = .exited
    
    var body: some View {
        VStack {
            Button("Add sprint") {
                sprints.create()
            }
            
            Carousel(sprints.sprints, type: .unbounded) { sprint in
                ZStack{
                    switch dropStatus {
                    case .entered:
                        Color.red.opacity(0.7)
                    case .exited:
                        Color.susieBluePriamry
                    case .dropped:
                        Color.green.opacity(0.7)
                    }
                    Text(sprint.name)
                }
                .cornerRadius(9)
                .padding()
                    .onDrop(of: [.text], delegate: SprintDropDelegate(backlog: backlog, dropStatus: $dropStatus, sprint: sprint))
            }
            
            List(backlog.issues) { issue in
                Text(issue.name)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete") {
                            backlog.delete(issue: issue)
                        }
                        .tint(.red)
                    }
                    .onDrag {
                        backlog.issue = issue
                        return NSItemProvider()
                    }
            }
        }
        .fullScreenCover(item: $sprints.sprint) { sprint in
            SprintView(sprint: sprint)
        }
        .onAppear {
            print("BACKLOG VIEW APPEARED")
        }
    }
    
    init(project: Project) {
        _backlog = StateObject(wrappedValue: BacklogViewModel(project: project))
        _sprints = StateObject(wrappedValue: SprintsViewModel(project: project))
    }
}

