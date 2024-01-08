import SwiftUI

@MainActor
struct BacklogView: View {
    @ObservedObject private var vm: BacklogViewModel
    
    var body: some View {
        NavigationStack {
            ScreenHeader(user: vm.user, title: LocalizedStringResource.localized.backlog) {
                Menu(content: {
                    NavigationLink("\(.localized.createSprint)") {
                        SprintFormView(project: vm.project)
                    }
               
                    NavigationLink("\(.localized.createIssue)") {
                        IssueFormView(project: vm.project)
                    }
                    
                }, label: { Image(systemName: "ellipsis").fontWeight(.bold) })
            }
            
            AsyncContentView(state: $vm.sprints, { sprints in
                switch sprints.isEmpty {
                case true:
                    NavigationLink(destination: {
                        SprintFormView(project: vm.project)
                    }, label: { CreateSprintView() })
                case false:
                    Carousel(sprints, type: .unbounded) { sprint in
                        SprintRowView(sprint: sprint, status: $vm.dropStatus)
                            .onTapGesture { vm.destinationButtonTapped(for: .details(sprint)) }
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
                            vm.destinationButtonTapped(for: .edit(issue))
                        }
                        .onTapGesture { vm.destinationButtonTapped(for: .edit(issue)) }
                        .onDrag{ vm.onDragIssueGesture(issue: issue) }
                    }
                }, placeholder: IssuePlaceholderView())
                
                NavigationLink("\(.localized.createIssue)") {
                    IssueFormView(project: vm.project)
                }
                .buttonStyle(.issueCreation)
                .offset(y: -15)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("\(LocalizedStringResource.localized.backlog)")
        .onAppear { vm.onAppear() }
        .refreshable { vm.onAppear() }
        .fullScreenCover(item: $vm.destination) { destination in
            switch destination {
            case let .details(sprint):
                SprintView(sprint: sprint, project: vm.project)
            case let .edit(issue):
                IssueDetailsView(issue: issue)
            }
        }
    }
    
    init(project: Project, user: User) { self._vm = ObservedObject(initialValue: BacklogViewModel(project: project, user: user)) }
}
