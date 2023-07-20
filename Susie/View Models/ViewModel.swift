import SwiftUI
import Combine

extension Issue {
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

class ViewModel: ObservableObject {
    @Injected(\.model) var model
    private var cancellabels = Set<AnyCancellable>()

    var isAuthenticated: Bool {
        model.isAuthenticated
        //Return true to bypass login
    }
    
    var issues: Array<Issue> {
        model.issues
    }
    
    //MARK: - Init
    //.recive(on: DispatchQueue.main) is used due "Updating UI should alwawys be done from main thread"
    
    init(){
        model.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.objectWillChange.send() }
            .store(in: &cancellabels)
        
        model.$issues
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in self?.objectWillChange.send() }
            .store(in: &cancellabels)
    }
                
    
    func authenticate(with credentials: AuthenticationRequest){
        model.authenticate(with: credentials)
    }
    
    func fetchIssues() {
        model.fetchIssues()
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

