class Task: Identifiable, Codable {
    var id: Int32
    var title: String
    var description: String
    var version: String //Wersja produktu, wersja oprogramowania która została wykupiona
    var deadline: String
    var businessValue: Int32 //Temp taking this value as a progress value | future task priority
    var assignee: User?
    //var progress: String
    var sprint: Sprint?
    //var tag: String
    
    init(id: Int32, title: String, description: String, version: String, deadline: String, businessValue: Int32) {
        self.id = id
        self.title = title
        self.description = description
        self.version = version
        self.deadline = deadline
        self.businessValue = businessValue
    }
}
