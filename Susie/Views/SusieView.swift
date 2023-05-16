import SwiftUI

struct SusieView: View {
    @StateObject var vm = ViewModel()
    
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
