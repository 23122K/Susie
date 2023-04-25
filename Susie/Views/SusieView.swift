import SwiftUI

struct SusieView: View {
    @StateObject var logic: Logic
    
    var body: some View {
        if(logic.isAuthenticated){
            AuthenticatedUserView()
                .environmentObject(logic)
        } else {
            WelcomePageView()
                .environmentObject(logic)
        }
    }
}

struct SusieView_Previews: PreviewProvider {
    static var previews: some View {
        SusieView(logic: Logic())
    }
}
