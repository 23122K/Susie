import SwiftUI

@MainActor
struct BacklogView: View {
    @ObservedObject private var vm: BacklogViewModel
    
    var body: some View {
        NavigationStack {
            ScreenHeader(user: vm.user, title: "\(vm.sprint?.name ?? LocalizedStringResource.localized.backlog.asString)") {
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
                        .onTapGesture { vm.issue = issue }
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
        .onAppear { vm.fetchInactiveSprintsAndIssues() }
        .refreshable { vm.fetchInactiveSprintsAndIssues() }
        .fullScreenCover(item: $vm.sprint) { sprint in
            SprintView(sprint: sprint, project: vm.project)
        }
        .fullScreenCover(item: $vm.issue) { issue in
            IssueDetailsView(issue: issue)
        }
    }
    
    init(project: Project, user: User) { self._vm = ObservedObject(initialValue: BacklogViewModel(project: project, user: user)) }
}
