import SwiftUI
import PartialSheet

struct AuthenticatedUserView: View {
    let project: Project
    let user: User
    
    var body: some View {
        TabView{
            HomeView(project: project, user: user)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            BoardsView(project: project, user: user)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "chart.bar.doc.horizontal.fill")
                    Text("Boards")
                }

            BacklogView(project: project, user: user)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "doc.plaintext.fill")
                    Text("Backlog")
                }

            DashboardView(project: project, user: user)
                .tabItem{
                    Image(systemName: "chart.bar.xaxis")
                    Text("Dashboard")
                }
        }
    }
}

//#Preview {
//    AuthenticatedUserView(project: ProjectDTO(name: "", description: "", goal: ""))
//}
