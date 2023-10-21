import SwiftUI
import Charts

struct DashboardView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject private var vm: DashboardViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ScreenHeader(user: vm.user, screenTitle: "Dashboard", action: {
                isPresented.toggle()
            }, content: {
                Menu(content: {
                    Button("Invite user") { isPresented.toggle() }
                    Button("Edit project") {}
                    Button("Delete project") {}
                }, label: {
                    Image(systemName: "ellipsis")
                        .scaleEffect(1.1)
                })
            })
            
            AsyncContentView(state: $vm.projectDetials, { project in
                ToggableSection(title: "Members", isToggled: true) {
                    MembersView(users: project.members)
                }
            }, placeholder: EmptyView(), onAppear: {
                vm.fetch()
            })
            .padding()
            
            Spacer()
        }
        .refreshable {
            vm.fetch()
        }
        .alert("Invite request", isPresented: $isPresented, actions: {
            TextField("email address", text: $vm.invitation.email)
            Button("Cancel") { } //After any action alert is dissmised automaticly
            Button("Invite", action: {
                vm.invite()
            })
        }, message: {
            Text("Invite member to your project")
        })
    }

    
    init(project: ProjectDTO) {
        _vm = StateObject(wrappedValue: DashboardViewModel(project: project))
    }
}

