//
//  SprintDropDelegate.swift
//  DragAndDrop
//
//  Created by Patryk Maciąg on 19/07/2023.
//

import SwiftUI

struct SprintDropDelegate: DropDelegate {
    @ObservedObject var vm: BacklogViewModel
    let sprint: Sprint
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        vm.dropStatus = .exited
        
        guard vm.assignIssue(to: sprint) else { return false }
        
        return true
    }
    
    func dropEntered(info: DropInfo) {
        vm.dropStatus = .entered
    }
    
    func dropExited(info: DropInfo) {
        vm.dropStatus = .exited
    }
}
