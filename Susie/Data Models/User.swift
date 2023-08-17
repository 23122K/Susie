struct UserDTO: Encodable {
    let uuid: String
    let email: String
    let firstName: String
    let lastName: String
    
    init(email: String, firstName: String, lastName: String) {
        self.uuid = ""
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}
