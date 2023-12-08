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
                }, placeholder: EmptyView())
                
                AsyncContentView(state: $vm.issueDetails, { issue in
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(.localized.comments)
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
                                    vm.deleteCommentButtonTapped(comment: comment)
                                }, onEdit: {
                                    vm.editCommentButtonTapped(comment: comment)
                                })
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                })
                
            }
            .onAppear { vm.onAppear() }
            .refreshable { vm.onAppear() }
            .scrollIndicators(.hidden)
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("\(.localized.dissmis)") {
                        dismiss()
                    }
                })
                
                ToolbarItem(placement: .keyboard) {
                    CommentTextInputView(text: $vm.comment.body, onSubmit: {
                        vm.postCommentButtonTapped()
                    })
                }
                
                ToolbarItem(placement: .bottomBar) {
                    TextField("\(.localized.addComment)", text: $vm.comment.body)
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
