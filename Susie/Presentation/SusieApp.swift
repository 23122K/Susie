import SwiftUI
import Factory

@main
struct Susie: App {
    @StateObject private var store: Store<AppState, AppAction> = Container.shared.appStore.resolve()
    
    var body: some Scene {
        WindowGroup {
            switch store.state.user {
            case .none: UnauthenticatedRootView()
            case let .some(user):
                switch store.state.project {
                case .none: ProjectSelectionView(user: user)
                case let .some(project): AuthenticatedRootView(project: project, user: user)
                }
            }
        }
    }
}
