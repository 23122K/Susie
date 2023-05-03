import SwiftUI
import Combine

extension Task {
    var color: Color {
        switch(self.tag) {
        case "Bug": return .red
        case "Story": return .blue
        case "Epic": return .purple
        case "Task": return .orange
        default: return .black
        }
    }
}

class Logic: ObservableObject {
    private(set) var model: Scrumapp
    private var cancellabels = Set<AnyCancellable>()

    var isAuthenticated: Bool {
        model.isAuthenticated
        //Return true to bypass login
    }
    
    var tasks: Array<Task> {
        model.tasks
    }
    
    //MARK: - Init
    //.recive(on: DispatchQueue.main) is used due "Updating UI should alwawys be done from main thread"
    init(){
        self.model = Scrumapp()
        model.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.objectWillChange.send() }
            .store(in: &cancellabels)
        
        model.$tasks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.objectWillChange.send() }
            .store(in: &cancellabels)
    }
                
    
    func authenticate(with credentials: AuthenticationRequest){
        model.authenticate(with: credentials)
    }
    
    func fetchTasks() {
        model.fetchTasks()
    }
    
    func getBoardNames() -> Array<String> {
        model.getBoardNames()
    }
    
    func signOut() {
        model.signOut()
    }
    
    
    func register(_ user: RegisterRequest) {
        model.register(user)
    }
    
}

