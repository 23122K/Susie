import Foundation


class Model: ObservableObject {
    private(set) var network: NetworkManager
    
    private var boards = ["To Do", "In progress", "In review", "Done"]
    
    //MARK: - Data fetched form 'Client' is stored below
    @Published private(set) var isAuthenticated: Bool = false
    @Published private(set) var sprints = Array<Sprint>()
    @Published private(set) var issues = Array<Issue>()
    
    
    //MARK: - Init
    init(network: NetworkManager = NetworkManager()) {
        self.network = network
        
        network.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .assign(to: &$isAuthenticated)

    }
    
    //Auth
    func signIn(with credentials: SignInRequest) {
        network.signIn(with: credentials)
    }
    
    func signUp(with credentials: SignUpRequest) {
        network.signUp(with: credentials)
    }
    
    func signOut() {
        network.signOut()
    }
    
    //MARK: - Static variable of prediefined agile boards name
    //Leave them as they are, in the future we might add option to customise them
    func getBoardNames() -> Array<String> {
        return boards
    }
    
    
}
