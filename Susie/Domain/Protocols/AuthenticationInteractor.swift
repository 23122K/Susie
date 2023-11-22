//
//  AuthenticationInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol AuthenticationInteractor {
    var repository: any RemoteAuthRepository { get }
}
