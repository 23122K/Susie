import SwiftUI

struct AuthenticatedUserView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem{
                    Image("home")
                    Text("Home")
                }
            
            BoardsView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Board")
                }
            
            BacklogsView()
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

struct AuthenticatedUserView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedUserView()
    }
}
