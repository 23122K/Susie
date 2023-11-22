//
//  ProjectInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/11/2023.
//

import Foundation

protocol ProjectInteractor {
    var repository: any RemoteProjectRepository { get }
}
