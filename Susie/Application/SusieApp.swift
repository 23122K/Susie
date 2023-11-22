import SwiftUI
import Factory

@main
struct Susie: App {
    @StateObject private var store: Store<AppState, AppAction> = Container.shared.appStore.resolve()
    
    var body: some Scene {
        WindowGroup {
            switch store.state.isAuthenticated {
            case true:
                ProjectsView()
            case false:
                WelcomePageView()
            }
        }
    }
}
