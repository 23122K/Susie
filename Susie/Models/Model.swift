import Foundation
import Combine

class Model: ObservableObject {
    private(set) var client: Client
    
    private var boards = ["To Do", "In progress", "In review", "Done"]
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Data fetched form 'Client' is stored below
    @Published private(set) var isAuthenticated: Bool = false
    @Published private(set) var issues = Array<Issue>()
    @Published private(set) var error: Error?
    
    
    //MARK: - Init
    init() {
        self.client = Client()
        client.$error
            .assign(to: &$error)
        
        client.$isAuthenticated
            .assign(to: &$isAuthenticated)
        
        client.$issues
            .assign(to: &$issues)
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
    func fetchIssues() {
        client.fetchIssues()
    }
    
    //MARK: - Static variable of prediefined agile boards name
    //Leave them as they are, in the future we might add option to customise them
    func getBoardNames() -> Array<String> {
        return boards
    }
    
    func dismissError() {
        self.error = nil
    }
    
}
