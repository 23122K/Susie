//
//  IssueDetailsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import SwiftUI
import PartialSheet
import SwipeActions

struct IssueDetailsView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject private var vm: IssueDetailsViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                AsyncContentView(state: $vm.issueDetails, { issue in
                    IssueDetailedFormView(issue: issue)
                }, placeholder: EmptyView(), onAppear: {
                    vm.fetch()
                })
                
                AsyncContentView(state: $vm.issueDetails, { issue in
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Comments")
                                    .foregroundStyle(Color.gray)
                                    .multilineTextAlignment(.leading)
                                Text(issue.comments.count.description)
                                    .multilineTextAlignment(.leading)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal,5)
                                    .background{
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(Color.susieWhiteSecondary)
                                    }
                                Spacer()
                            }
                            .padding(.horizontal)
                            .fontWeight(.semibold)
                            
                            ForEach(issue.comments) { comment in
                                SwipeContent({
                                    CommentRowView(comment: comment)
                                }, onDelete: {
                                    vm.delete(comment: comment)
                                }, onEdit: {
                                    vm.comment.body = comment.body
                                })
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                })
                
            }
            .refreshable { vm.fetch() }
            .scrollIndicators(.hidden)
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Close") {
                        dismiss()
                    }
                })
                
                ToolbarItem(placement: .keyboard) {
                    CommentTextInputView(text: $vm.comment.body, onSubmit: {
                        vm.post()
                    })
                }
                
                ToolbarItem(placement: .bottomBar) {
                    TextField("Add comment...", text: $vm.comment.body)
                        .textFieldStyle(.susieSecondaryTextField)
                }
            }
        }
        .attachPartialSheetToRoot()
    }
    
    init(issue: IssueGeneralDTO) {
        _vm = StateObject(wrappedValue: IssueDetailsViewModel(issue: issue))
    }
}
