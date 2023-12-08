import SwiftUI

struct DashboardView: View {
    @Environment (\.dismiss) private var dismiss
    @ObservedObject var vm: DashboardViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ScreenHeader(user: vm.user, title: "\(LocalizedStringResource.localized.dashboard)") {
                    Menu(content: {
                        Button("\(.localized.addNewMember)") { isPresented.toggle() }
                        
                        NavigationLink("\(.localized.editProject)") {
                            ProjectFormView(project: vm.project)
                        }
                        
                        NavigationLink("\(.localized.definitionOfDone)") {
                            DefinitionOfDoneView(project: vm.project)
                        }
                        
                        Section {
                            Button(role: .destructive, action: {
                                print("DELETED")
                            }, label: {
                                Text(.localized.deleteProject)
                            })
                        }
                    }, label: {
                        Image(systemName: "ellipsis")
                            .scaleEffect(1.1)
                    })
                }
                
                ToggableSection(title: .localized.members, isToggled: true) {
                    MembersView(users: vm.project.members)
                }
                
                .padding()
                
                Spacer()
            }
            .refreshable { vm.fetchProjectDetails() }
            .alert("Invite request", isPresented: $isPresented, actions: {
                TextField("\(.localized.email)", text: $vm.invitation.email)
                Button("\(.localized.cancel)") { } //After any action alert is dissmised automaticly
                Button("\(.localized.invite)", action: { vm.inviteButtonTapped() })
            }, message: { Text(verbatim: "Invite member to your project") })
        }
    }

    
    init(project: Project, user: User) { self._vm = ObservedObject(initialValue: DashboardViewModel(project: project, user: user)) }
}

