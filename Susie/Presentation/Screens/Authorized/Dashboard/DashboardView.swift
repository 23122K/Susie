import SwiftUI
import Charts

struct DashboardView: View {
    @Environment (\.dismiss) private var dismiss
    @ObservedObject var vm: DashboardViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ScreenHeader(user: vm.user, screenTitle: "Dashboard") {
                    Menu(content: {
                        Button("Add new member") { isPresented.toggle() }
                        
                        NavigationLink("Edit project", destination: {
                            ProjectFormView(project: vm.project)
                        })
                        
                        Section {
                            Button(role: .destructive, action: {
                                print("DELETED")
                            }, label: {
                                Text("Delete project")
                            })
                        }
                    }, label: {
                        Image(systemName: "ellipsis")
                            .scaleEffect(1.1)
                    })
                }
                
                ToggableSection(title: "Members", isToggled: true) {
                    MembersView(users: vm.project.members)
                }
                .padding()
                
                Spacer()
            }
            .refreshable { vm.fetchProjectDetails() }
            .alert("Invite request", isPresented: $isPresented, actions: {
                TextField("email address", text: $vm.invitation.email)
                Button("Cancel") { } //After any action alert is dissmised automaticly
                Button("Invite", action: { vm.inviteButtonTapped() })
            }, message: { Text("Invite member to your project") })
        }
    }

    
    init(project: Project, user: User) { self._vm = ObservedObject(initialValue: DashboardViewModel(project: project, user: user)) }
}

