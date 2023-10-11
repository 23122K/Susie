//
//  IssueDetailedView.swift
//  Susie
//
//  Created by Patryk Maciąg on 11/10/2023.
//

import SwiftUI

struct IssueDetailedView: View {
    private let issue: Issue
    
    var body: some View {
        VStack {
            Text(issue.name)
            Text(issue.asignee?.fullName ?? "Not assigned")
            Text(issue.type.description)
            Text(issue.status.description)
            Text(issue.priority.description)
        }
    }
    
    init(issue: Issue) {
        self.issue = issue
    }
}

