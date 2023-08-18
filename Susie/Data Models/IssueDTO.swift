
struct IssueDTO: Request {
    let issueID: Int32
    let name: String
    let description: String
    let estimation: Int32
    let projectID: Int32
}
