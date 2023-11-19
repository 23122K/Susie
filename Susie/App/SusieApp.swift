
import ComposableArchitecture
import SwiftUI

@main
struct Susie: App {
    @State var store = Store(initialState: AppFeature.State()) {
        AppFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
