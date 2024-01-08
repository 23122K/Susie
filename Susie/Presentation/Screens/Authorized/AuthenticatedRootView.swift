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
                }
            
            BoardsView(project: project, user: user)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "chart.bar.doc.horizontal.fill")
                }

            BacklogView(project: project, user: user)
                .attachPartialSheetToRoot()
                .tabItem{
                    Image(systemName: "doc.plaintext.fill")
                }

            DashboardView(project: project, user: user)
                .tabItem{
                    Image(systemName: "chart.bar.xaxis")
                }
        }
    }
}

#Preview {
    AuthenticatedRootView(project: .mock, user: .mock)
}
