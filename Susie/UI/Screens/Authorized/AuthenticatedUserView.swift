import SwiftUI

struct AuthenticatedUserView: View {
    let project: Project
    
    var body: some View {
        TabView{
            BoardsView(project: project)
                .tabItem{
                    Image(systemName: "house")
                    Text("Board")
                }

            BacklogView(project: project)
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Backlog")
                }

            DashboardView()
                .tabItem{
                    Image("dashboard")
                    Text("Dashboard")
                }
        }
    }
}
