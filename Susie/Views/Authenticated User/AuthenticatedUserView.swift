import SwiftUI

struct AuthenticatedUserView: View {
    var body: some View {
        LoggedPersonView()
        TabView{
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
                    Image(systemName: "speedometer")
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
