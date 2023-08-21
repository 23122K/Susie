//
//  CaheEntry.swift
//  SusieTest
//
//  Created by Patryk Maciąg on 21/08/2023.
//

import Foundation

final class ResponseObject: NSDiscardableContent {
    func beginContentAccess() -> Bool {
        return true
    }
    
    func endContentAccess() {
    }
    
    func discardContentIfPossible() {
    }
    
    func isContentDiscarded() -> Bool {
        return false
    }
    
    internal let entry: RequestStatus
    
    init(entry: RequestStatus) {
        self.entry = entry
    }
}

enum RequestStatus {
    case inProgress(Task<any Response, Error>)
    case completed(any Response)
}



