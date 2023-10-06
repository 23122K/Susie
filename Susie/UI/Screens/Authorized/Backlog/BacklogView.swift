import SwiftUI

@MainActor
struct BacklogView: View {
    @StateObject private var backlog: BacklogViewModel
    @StateObject private var sprints: SprintsViewModel
    @State private var dropStatus: DropStatus = .exited
    
    var body: some View {
        GeometryReader { reader in
            NavigationStack {
                HStack(alignment: .lastTextBaseline) {
                    ScreenHeader(user: backlog.user, screenTitle: "Projects", content: {
                        NavigationLink("+", destination: {
                            ProjectView()
                        })
                    })
                    .onTapGesture {
//                        isShown.toggle()
                    }
                }
                .padding(.horizontal)
                
                if sprints.sprints.isEmpty {
                    NavigationLink(destination: {
                        SprintFormView()
                    }, label: {
                        ZStack {
                            Color.susieWhiteSecondary
                            Text("Add sprint")
                                .fontWeight(.semibold)
                        }
                        .cornerRadius(9)
                        .padding()
                        .frame(width: reader.size.width, height: 200)
                    })
                } else {
                    Carousel(sprints.sprints, type: .unbounded) { sprint in
                        ZStack{
                            switch dropStatus {
                            case .entered:
                                Color.red.opacity(0.7)
                            case .exited:
                                Color.susieBluePriamry
                            }
                            Text(sprint.name)
                        }
                        .cornerRadius(9)
                        .padding()
                        .onTapGesture { sprints.sprint = sprint }
                        .onDrop(of: [.text], delegate: SprintDropDelegate(backlog: backlog, dropStatus: $dropStatus, sprint: sprint))
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    ForEach(backlog.issues) { issue in
                        IssueRowView(issue: issue)
                            .padding(.horizontal)
                            .onDrag {
                                backlog.issue = issue
                                return NSItemProvider()
                            }
                    }
                    
                    
                    
                    NavigationLink("Create issue", destination: {
                        IssueFormView(project: backlog.project)
                    })
                    .buttonStyle(.issueCreation)
                    .offset(y: -15)
                }
                
                Spacer()
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

