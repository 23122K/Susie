import SwiftUI

class ClientViewModel: ObservableObject {
    @Injected(\.model) var model

    @Published var isAuthenticated = false
    @Published var issues = Array<Issue>()
    @Published var sprints = Array<Sprint>()
    
    //MARK: - Init
    //.recive(on: DispatchQueue.main) is used due "Updating UI should alwawys be done from main thread"
    
    init(){
        model.$isAuthenticated
            .receive(on: DispatchQueue.main)
            .assign(to: &$isAuthenticated)
        
        model.$issues
            .assign(to: &$issues)
        
        model.$sprints
            .assign(to: &$sprints)
        
//        model.$sprints
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] _ in self?.objectWillChange.send() }
//            .store(in: &cancellabels)
//
//        model.$issues
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] _ in self?.objectWillChange.send() }
//            .store(in: &cancellabels)
    }
                
    
    func signIn(with credentials: SignInRequest){
        model.signIn(with: credentials)
    }
    
    func getBoardNames() -> Array<String> {
        model.getBoardNames()
    }
    
    func signOut() {
        model.signOut()
    }
    
    func signUp(with credentials: SignUpRequest) {
        model.signUp(with: credentials)
    }
    
}

