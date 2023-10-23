import SwiftUI
import PartialSheet

struct AuthenticatedUserView: View {
    let project: ProjectDTO
    
    var body: some View {
        TabView{
            HomeView(project: project)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            BoardsView(project: project)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "chart.bar.doc.horizontal.fill")
                    Text("Boards")
                }

            BacklogView(project: project)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "doc.plaintext.fill")
                    Text("Backlog")
                }

            DashboardView(project: project)
                .tabItem{
                    Image(systemName: "chart.bar.xaxis")
                    Text("Dashboard")
                }
        }
    }
}

#Preview {
    AuthenticatedUserView(project: ProjectDTO(name: "", description: "", goal: ""))
}
