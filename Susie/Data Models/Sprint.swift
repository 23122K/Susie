struct Sprint: Codable {
    var id: Int32
    var name: String
    var dateFrom: String
    var dateExpiration: String
    var team: Team
    var issues: Array<Issue>
}
