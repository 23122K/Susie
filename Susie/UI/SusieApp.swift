import SwiftUI

@main
struct Susie: App {
    @StateObject private var vm = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
            switch vm.isAuthenticted {
            case true:
                ProjectsView()
            case false:
                WelcomePageView()
            }
        }
    }
}
