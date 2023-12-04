import SwiftUI
import PartialSheet

struct AuthenticatedRootView: View {
    let project: Project
    let user: User
    
    var body: some View {
        TabView{
            HomeView(project: project, user: user)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text(verbatim: "Home")
                }
            
            BoardsView(project: project, user: user)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "chart.bar.doc.horizontal.fill")
                    Text(verbatim: "Boards")
                }

            BacklogView(project: project, user: user)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "doc.plaintext.fill")
                    Text(verbatim: "Backlog")
                }

            DashboardView(project: project, user: user)
                .tabItem{
                    Image(systemName: "chart.bar.xaxis")
                    Text(verbatim: "Dashboard")
                }
        }
    }
}

#Preview {
    AuthenticatedRootView(project: .mock, user: .mock)
}
