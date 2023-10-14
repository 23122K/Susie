//
//  SprintDropDelegate.swift
//  DragAndDrop
//
//  Created by Patryk Maciąg on 19/07/2023.
//

import SwiftUI

enum DropStatus {
    case entered
    case exited
}

struct SprintDropDelegate: DropDelegate {
    @ObservedObject var sprints: SprintsViewModel
    @Binding var dropStatus: DropStatus
    
    let sprint: Sprint
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        sprints.assign(to: sprint) ? true : false
    }
    
    func dropEntered(info: DropInfo) {
        dropStatus = .entered
    }
    
    func dropExited(info: DropInfo) {
        dropStatus = .exited
    }
}
