import SwiftUI
import PartialSheet

struct AuthenticatedUserView: View {
    let project: ProjectDTO
    
    var body: some View {
        TabView{
            HomeView(project: project)
                .tabItem{
                    Text("Home")
                }
            
            BoardsView(project: project)
                .tabItem{
                    Text("Board")
                }

            BacklogView(project: project)
                .attachPartialSheetToRoot()
                .tabItem{
                    Text("Backlog")
                }

            DashboardView(project: project)
                .tabItem{
                    Text("Dashboard")
                }
        }
    }
}

#Preview {
    AuthenticatedUserView(project: ProjectDTO(name: "", description: "", goal: ""))
}
