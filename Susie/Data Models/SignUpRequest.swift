
struct SignUpRequest: Codable {
    let username: String
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let isScrumMaster: Bool
    
    init(firstName: String, lastName: String, email: String, username: String, password: String, isScrumMaster: Bool = false) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.password = password
        self.isScrumMaster = isScrumMaster
    }
}
