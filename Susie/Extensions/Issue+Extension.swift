import Foundation

extension Issue {
    var tag: String {
        let tags = ["Story", "Epic", "Task"]
        return tags.randomElement()!
    }
}
