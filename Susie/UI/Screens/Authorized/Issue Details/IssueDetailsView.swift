//
//  IssueDetailsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import SwiftUI
import PartialSheet

struct IssueDetailsView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject private var vm: IssueDetailsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                AsyncContentView(state: $vm.issueDetails, { issue in
                    IssueDetailedFormView(issue: issue)
                        .attachPartialSheetToRoot()
                }, placeholder: EmptyView(), onAppear: {
                    vm.fetch()
                })
            }
            .scrollIndicators(.hidden)
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Close") {
                        dismiss()
                    }
                })
            }
        }
        
    }
    
    init(issue: IssueGeneralDTO) {
        _vm = StateObject(wrappedValue: IssueDetailsViewModel(issue: issue))
    }
}
