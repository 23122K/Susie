struct RegisterRequest: Codable {
    var firstname: String
    var lastname: String
    var email: String
    var password: String
    
    init(firstname: String, lastname: String, email: String, password: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
    }
}
