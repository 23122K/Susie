import Foundation
import Combine

class Model: ObservableObject {
    private(set) var client: Client
    
    private var boards = ["To Do", "In progress", "In review", "Done"]
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Data fetched form 'Client' is stored below
    @Published private(set) var isAuthenticated: Bool = false
    @Published private(set) var tasks = Array<Task>()
    
    
    //MARK: - Init
    init() {
        self.client = Client()
        client.$isAuthenticated
            .sink(receiveValue: { status in
                self.isAuthenticated = status
            })
            .store(in: &cancellables)
        
        client.$tasks
            .sink(receiveValue: { tasks in
                self.tasks = tasks
            })
            .store(in: &cancellables)
    }
    
    
    //MARK: - Sign in
    func authenticate(with credentials: AuthenticationRequest){
        client.authenticate(with: credentials)
    }
    
    //MARK: - Sign up
    func register(_ user: RegisterRequest) {
        client.register(user)
    }
    
    //MARK: - Sign out
    func signOut() {
        client.signOut()
    }
    
    //MARK: - Fetches tasks assigned to logged user
    func fetchTasks() {
        client.fetchTasks()
    }
    
    //MARK: - Static variable of prediefined agile boards name
    //Leave them as they are, in the future we might add option to customise them
    func getBoardNames() -> Array<String> {
        return boards
    }
    
}
