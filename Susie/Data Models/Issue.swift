
struct Issue: Identifiable, Response {
    let id: Int32
    let name: String
    let description: String
    let estimation: Int32
    let reporter: User
    let assignee: User?
    let backlog: Backlog
    let comments: Array<Comment>
    let sprint: Sprint?
}
