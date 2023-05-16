import Foundation
import Combine

class Client: ObservableObject {
    
    //MARK: - JWT Token
    //Well as it is so called secret, it should't be kept here <- Use keychain? in development earlier
    //https://developer.apple.com/documentation/security/keychain_services/keychain_items/using_the_keychain_to_manage_user_secrets
    
    private var token: String? {
        willSet(token){
            isAuthenticated.toggle()
            //print(isAuthenticated.description)
        }
    }
    private(set) var cancellables = Set<AnyCancellable>()
    
    //MARK: Variables published to model
    @Published private(set) var tasks = Array<Task>()
    @Published private(set) var isAuthenticated = false
    
    //MARK: - Sign out - logs out user from current session
    func signOut() {
        self.token = nil
    }
    
    //MARK: - Authentication function, also fetches tasks from db if authentication was granted
    func authenticate(with credentials: AuthenticationRequest) {
        let url = HTTPClient.createURL(endpoint: .authenticate)
        let data = try? JSONEncoder().encode(credentials)
        
        if let data = data {
            let request = HTTPClient.createRequest(url, data)
            let publisher: AnyPublisher<AuthenticationResponse, Error> = HTTPClient.fetchDataFromRequest(request)
            
            publisher
                .sink(receiveCompletion: { completion in
                    switch(completion){
                    case .finished:
                        self.fetchTasks()
                    case .failure(let err): print(err)
                    }
                }, receiveValue: { (response: AuthenticationResponse) in
                    self.token = response.token
                })
                .store(in: &cancellables)
        }
    }
    
    //MARK: - fetches tasks from DB assigned to logged user
    func fetchTasks() {
        let url = HTTPClient.createURL(endpoint: .getTasks)
        if let token = self.token {
            let request = HTTPClient.createRequest(url, .GET, token)
            
            let publisher: AnyPublisher<Array<Task>, Error> = HTTPClient.fetchDataFromRequest(request)
            
            publisher
                .sink(receiveCompletion: { completion in
                    switch(completion){
                    case .finished: print("Task fetched succesfully!")
                    case .failure(let err): print(err)
                    }
                }, receiveValue: { (tasks: Array<Task>) in
                    self.tasks.removeAll()
                    self.tasks = tasks
                })
                .store(in: &cancellables)
        }
        
        
    }
    
    //MARK: - Register user + automatic sign in if succesfull
    func register(_ user: RegisterRequest) {
        let url = HTTPClient.createURL(endpoint: .register)
        let data = try? JSONEncoder().encode(user)
        
        if let data = data {
            let request = HTTPClient.createRequest(url, data)
            let publisher: AnyPublisher<AuthenticationResponse, Error> = HTTPClient.fetchDataFromRequest(request)
            let credentials = AuthenticationRequest(email: user.email, password: user.password)
            
            publisher
                .handleEvents(receiveOutput: { _ in})
                .sink(receiveCompletion: { completion in
                    switch(completion) {
                    case .failure(let err): print(err)
                    case .finished: self.authenticate(with: credentials)
                    }
                }, receiveValue: { _ in }) //Register token is unused due to first attribute
                .store(in: &cancellables)
        }
    }
}
