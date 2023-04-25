class User: Codable {
    var id: Int32
    var firstname: String
    var lastname: String
    var email: String
    var password: String
    var role: String
    var tasks: Array<Task>
    var team: Team
    var enabled: Bool
    var accountNonExpired: Bool
    var accountNonLocked: Bool
    var credentialsNonExpired: Bool
    var authorities: GrantedAuthority
    var username: String
}
