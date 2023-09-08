//
//  SprintDropDelegate.swift
//  DragAndDrop
//
//  Created by Patryk Maciąg on 19/07/2023.
//

import SwiftUI

struct SprintDropDelegate: DropDelegate {
    @Binding var issue: Issue?
    @Binding var source: Array<Issue>
    @Binding var destination: Sprint
    @Binding var isInDropArea: Bool
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        guard let issue = issue else {
            dropFinalise()
            return false
        }
        
//        destination.issues.append(issue)
//        source.removeAll(where: { $0.id == issue.id})
        dropFinalise()
        return true
    }
    
    
    func dropEntered(info: DropInfo) {
        print("Sprint drop area entered ")
        isInDropArea = true
    }
    
    func dropExited(info: DropInfo) {
        print("Sprint drop area exited ")
        isInDropArea = false
    }
    
    func dropFinalise() {
        isInDropArea = false
        issue = nil
    }
}
