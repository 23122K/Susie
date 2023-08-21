import Foundation

extension Issue {
    var status: Int {
        return Int.random(in: 0..<4)
    }
}
