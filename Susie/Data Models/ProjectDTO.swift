
struct ProjectDTO: Encodable {
    let projectID: Int32
    let name: String
    let description: String
    
    init(name: String, description: String) {
        self.projectID = 0
        self.name = name
        self.description = description
    }
}
