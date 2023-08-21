import SwiftUI

struct SusieView: View {
    @StateObject var vm = ClientViewModel()
    
    var body: some View {
        if(vm.isAuthenticated){
            AuthenticatedUserView()
                .environmentObject(vm)
        } else {
            WelcomePageView()
                .environmentObject(vm)
        }
    }
}

struct SusieView_Previews: PreviewProvider {
    static var previews: some View {
        SusieView()
    }
}
