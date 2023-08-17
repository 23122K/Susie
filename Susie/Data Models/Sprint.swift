import Foundation

struct Sprint: Identifiable, Codable {
    let id: Int32
    let name: String
    let startDate: Date //Gotta map response from string into data
    let project: Project
    let sprintIssues: Array<Issue>
}
