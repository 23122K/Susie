
import ComposableArchitecture
import SwiftUI

@main
struct Susie: App {
    var body: some Scene {
        WindowGroup {
            AppView(store: Store(initialState: AppFeature.State()) {
                AppFeature()
            })
        }
    }
}
