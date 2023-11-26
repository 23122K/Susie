//
//  IssueInteractor.swift
//  Susie
//
//  Created by Patryk Maciąg on 25/11/2023.
//

import Foundation

protocol IssueInteractor {
    var repository: any RemoteIssueRepository { get }
}
