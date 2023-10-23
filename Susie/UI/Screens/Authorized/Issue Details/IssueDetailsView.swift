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
    @State var test: String = ""
    
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
                                })
                            }
//                            ForEach(issue.comments) { comment in
//                                SwipeView(label: {
//                                    CommentRowView(comment: comment)
//                                }, leadingActions: { _ in
//                                    SwipeAction(action: {
//                                        vm.delete(comment: comment)
//                                    }, label: { _ in
//                                        HStack {
//                                            Text("Delete")
//                                                .fontWeight(.semibold)
//                                            Image(systemName: "trash.fill")
//                                        }
//                                        .foregroundColor(Color.susieWhitePrimary)
//                                    }, background: { _ in
//                                        Color.red.opacity(0.95)
//                                    })
//                                    .allowSwipeToTrigger()
//                                    
//                                }, trailingActions: { _ in
//                                    SwipeAction(action: {
//            //                            vm.issue = issue
//                                    }, label: { _ in
//                                        HStack {
//                                            Text("Edit")
//                                            Image(systemName: "pencil")
//                                        }
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(Color.susieWhitePrimary)
//                                    }, background: { _ in
//                                        Color.susieBluePriamry
//                                    })
//                                    .allowSwipeToTrigger()
//                                })
//                                .swipeSpacing(10)
//                                .swipeMinimumDistance(10)
//                                .swipeActionsStyle(.cascade)
//                                .swipeActionsMaskCornerRadius(9)
//                                .swipeActionCornerRadius(9)
//                                .padding(.horizontal)
//                            }
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
