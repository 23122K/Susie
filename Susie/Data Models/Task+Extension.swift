import Foundation


extension Task {
    var tag: String {
        let tags = ["Story", "Epic", "Task"]
        return tags.randomElement()!
    }
}
