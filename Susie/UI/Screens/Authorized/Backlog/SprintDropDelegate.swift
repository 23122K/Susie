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
    @ObservedObject var backlogViewModel: BacklogViewModel
    @Binding var dropStatus: DropStatus
    var sprint: Sprint
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        dropStatus = .exited
        
        guard backlogViewModel.assign(to: sprint) else {
            return false
        }
        
        return true
    }
    
    func dropEntered(info: DropInfo) {
        dropStatus = .entered
    }
    
    func dropExited(info: DropInfo) {
        dropStatus = .exited
    }
}
