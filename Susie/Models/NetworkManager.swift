import Foundation
import Combine

class NetworkManager: ObservableObject {
    
    private var refreshToken: String?
    private var token: String? {
        willSet { isAuthenticated.toggle() }
    }
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Variables published to model
    @Published private(set) var issues = Array<Issue>()
    @Published private(set) var projects = Array<Project>()
    @Published private(set) var isAuthenticated = false
    @Published private(set) var error: Error?
    
    //MARK: - Authentication Sign up/in/out
    func signIn(with credentials: SignInRequest) {
        let url = APIManager.createURL(for: .signIn)
        let data = try? JSONEncoder().encode(credentials)
        
        if let data = data {
            let request = APIManager.createRequest(to: url, method: .POST, payload: data)
            let publisher: AnyPublisher<SignInResponse, Error> = APIManager.fetchData(from: request)
            
            publisher
                .sink(receiveCompletion: { completion in
                    switch(completion){
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        print("Failed")
                        print(error)
                    }
                }, receiveValue: { (response: SignInResponse) in
                    self.token = response.accessToken
                    self.refreshToken = response.refreshToken
                })
                .store(in: &cancellables)
        }
    }
    
    func signOut() {
        self.token = nil
        self.refreshToken = nil
    }
        
    //Sends sign up request, if completed succesfully calls signIn(with: SignInRequest) to authenticate user
    func signUp(with credentials: SignUpRequest) {
        let url = APIManager.createURL(for: .signUp)
        let data = try? JSONEncoder().encode(credentials)
        
        if let data = data {
            let request = APIManager.createRequest(to: url, method: .POST, payload: data)
            let publisher: AnyPublisher<SignUpResponse, Error> = APIManager.fetchData(from: request)
            
            publisher
                .handleEvents(receiveOutput: { _ in})
                .sink(receiveCompletion: { completion in
                    switch(completion) {
                    case .failure(let error):
                        print(error)
                        self.error = error
                    case .finished:
                        let credentials = SignInRequest(email: credentials.email, password: credentials.password)
                        self.signIn(with: credentials)
                    }
                }, receiveValue: { (response: SignUpResponse) in
                    print(response.result)
                    
                }) //Register token is unused due to first attribute
                .store(in: &cancellables)
        }
    }
    
    //MARK: Scrum Master
    func createProject(with details: ProjectDTO) {
        let endpoint = APIManager.createURL(for: .project)
        let data = try? JSONEncoder().encode(details)
        
        if let data = data, let token = token {
            let request = APIManager.createRequest(to: endpoint, using: .POST, payload: data, token: token)
            let publisher: AnyPublisher<Project, Error> = APIManager.fetchData(from: request)
            
            publisher
                .handleEvents(receiveOutput: { _ in})
                .sink(receiveCompletion: { completion in
                    switch(completion) {
                    case .failure(let error):
                        print(error)
                        self.error = error
                    case .finished:
                       print("Finished")
                    }
                }, receiveValue: { (project: Project) in
                    print(project)
                    
                }) //Register token is unused due to first attribute
                .store(in: &cancellables)
        }
    }
    
    func fetchProjects() {
        if let token = token {
            let endpoint = APIManager.createURL(for: .project)
            print("1")
            let request = APIManager.createRequest(to: endpoint, using: .GET, token: token)
            print("2")
            let publisher: AnyPublisher<[Project], Error> = APIManager.fetchData(from: request)
            print("3")
            publisher
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch(completion) {
                    case .failure(let error):
                        print(error)
                        self.error = error
                    case .finished:
                       print("Fetched all projects")
                    }
                }, receiveValue: { (projects: Array<Project>) in
                    print(projects)
                    //self.projects = projects
                })
                .store(in: &cancellables)
            
        }
    }
    
//    func assign(_ user: UserDTO, to project: ProjectDTO) {
//        let endpoint = APIManager.createURL(for: .assignUser)
//        let userAssociation = UserAssociationDTO(email: user.email, projectID: project.projectID)
//        let data = try? JSONEncoder().encode(userAssociation)
//
//        if let data = data, let token = token {
//            let request = APIManager.createRequest(to: endpoint, using: .POST, payload: data, token: token)
//            let publisher: AnyPublisher<Void, Error> = APIManager.fetchData(from: request)
//
//            publisher
//                .handleEvents(receiveOutput: { _ in})
//                .sink(receiveCompletion: { completion in
//                    switch(completion) {
//                    case .failure(let error):
//                        print(error)
//                        self.error = error
//                    case .finished:
//                       print("Succesfully added user to project")
//                    }
//                }, receiveValue: { _ in })
//                .store(in: &cancellables)
//        }
//    }
}
