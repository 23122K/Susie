//
//  IssueDetailsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import SwiftUI

struct OptionalIssueDetailsView: View {
    @StateObject private var issueDetails: IssueDetailsViewModel
    
    var body: some View {
        AsyncContentView(source: issueDetails) { issue in
            ScrollView(showsIndicators: false) {
                TextField("Issue title", text: .constant("Super issue name"))
                    .textFieldStyle(.susiePrimaryTextField)
                ToggableSection(title: "Description") {
                    Text(issue.description)
                }
            }
            .padding()
        }
    }
    
    init(issue: IssueGeneralDTO) throws {
        let wrappedValue = try IssueDetailsViewModel(issue: issue)
        _issueDetails = StateObject(wrappedValue: wrappedValue)
    }
}

struct IssueDetailsView: View {
    private let issue: IssueGeneralDTO
    
    var body: some View {
        VStack {
            if let issueDetailsView = try? OptionalIssueDetailsView(issue: issue) {
                Text("XD")
                issueDetailsView
            } else {
                Text("Error while fetching data")
            }
        }
    }
    
    init(issue: IssueGeneralDTO) {
        self.issue = issue
    }
}
