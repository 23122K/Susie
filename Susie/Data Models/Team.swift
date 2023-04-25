class Team: Codable {
    var id: Int32
    var name: String
    var domain: String
    var description: String
    var users: Array<User>
    var sprints: Array<Sprint>
    var teamIdentifier: String
}
