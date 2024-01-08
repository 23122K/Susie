//
//  UserInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol UserInteractor {
    var repository: any RemoteUserRepository { get }
    
    func signedUserInfo() async throws
}
