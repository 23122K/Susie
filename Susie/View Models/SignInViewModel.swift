//
//  SignInViewModel.swift
//  Susie
//
//  Created by Patryk Maciąg on 15/05/2023.
//

import SwiftUI
import Combine


class SignInViewModel: ObservableObject {
    //MARK: Input
    @Injected(\.model) var model
    @Published var emialAddress = ""
    @Published var password = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Output
    var isValid: Bool {
        if (emialAddress != "" && password != "") {
            return true
        }
        
        return false
    }
    
    var error: (occured: Bool, description: String) {
        if let error = model.error {
            dismissError()
            return (true, error.localizedDescription)
        }
        
        return (false, String())
    }
    
    func authenticate() {
        let request = AuthenticationRequest(email: self.emialAddress, password: self.password)
        model.authenticate(with: request)
    }
    
    func dismissError() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.model.dismissError()
        })
    }

    //MARK: Init
    init() {
        model.$error
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] _ in self?.objectWillChange.send() }
            .store(in: &cancellables)
    }
    
    
}
