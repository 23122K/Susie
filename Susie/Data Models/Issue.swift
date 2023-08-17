
struct Issue: Identifiable, Equatable, Codable {
    let id: Int32
    let name: String
    let description: String
    let estimation: Int32
    let reporterID: String
    let assigneeID: Int32
    let backlog: Backlog
    let comments: Array<Comment>
    let sprint: Sprint?
    
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        return lhs.id == rhs.id
    }
}
