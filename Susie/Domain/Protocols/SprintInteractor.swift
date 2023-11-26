//
//  SprintInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 25/11/2023.
//

import Foundation

protocol SprintInteractor {
    var repository: any RemoteSprintRepository { get }
}
