class Sprint: Codable {
    var id: Int32
    var name: String
    var date_from: String
    var date_expiration: String
    var team: Team
    var tasks: Array<Task>
}
