//
//  IssueDetailsView.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import SwiftUI
import Factory

@MainActor
class IssueDetailedFormViewModel: ObservableObject {
    private var client: Client
    @Published var issue: Issue
    
    init(issue: Issue, container: Container = Container.shared) {
        self.client = container.client()
        
        _issue = Published(initialValue: issue)
    }
}

struct IssueDetailedFormView: View {
    @StateObject private var vm: IssueDetailedFormViewModel
    @State private var isPriorityPresented: Bool = false
    @State private var isStatusPresented: Bool = false
    @State private var isTypePresented: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TextField("Issue title", text: $vm.issue.name)
                .textFieldStyle(.susiePrimaryTextField)
            
            ToggableSection(title: "Description", isToggled: true) {
                TextField("Description", text: $vm.issue.description, axis: .vertical)
                    .lineLimit(2...)
                    .textFieldStyle(.susieSecondaryTextField)
            }
            
            ToggableSection(title: "Details") {
                Button(action: {
                    isPriorityPresented.toggle()
                }, label: {
                    VStack(alignment: .leading) {
                        Text("Priority")
                            .font(.caption)
                        TagView(text: vm.issue.priority.description, color: vm.issue.priority.color)
                    }
                    .foregroundColor(.black)
                })
            }
        }
        .padding()
        .customSheet(isPresented: $isPriorityPresented) {
            TagPickerView(enum: $vm.issue.priority)
        }
    }
    
    init(issue: Issue) {
        _vm = StateObject(wrappedValue: IssueDetailedFormViewModel(issue: issue))
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

public extension View {
    func customSheet<SheetContent: View>(isPresented: Binding<Bool>, @ViewBuilder _ content: @escaping () -> SheetContent) -> some View {
        @State var sheetHeight: CGFloat = .zero
        
        lazy var sheet: some View = {
            self.sheet(isPresented: isPresented, content: content)
                .padding()
                .overlay {
                    GeometryReader { geometry in
                        Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                    }
                }
                .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                    sheetHeight = newHeight
                }
        }()
        
        return sheet.presentationDetents([.height(sheetHeight)])
    }
}

struct TagPickerView<Enum: Tag>: View where Enum: Hashable, Enum.AllCases: RandomAccessCollection, Enum.RawValue == Int32 {
    @Binding var `enum`: Enum
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Enum.allCases, id: \.rawValue) { `case` in
                Button(action: {
                    `enum` = `case`
                }, label: {
                    VStack {
                        TagView(text: `case`.description, color: `case`.color, enlarged: true)
                        Text(`case`.description)
                            .font(.caption)
                    }
                })
                .padding(.bottom, 1)
                Divider()
            }
        }
        .padding()
    }
}

struct IssueDetailsView: View {
    @Environment (\.dismiss) private var dismiss
    @StateObject private var issueDetails: IssueDetailsViewModel
    
    var body: some View {
        NavigationStack {
            AsyncContentViewV2(state: $issueDetails.state, { issue in
                IssueDetailedFormView(issue: issue)
            }, placeholder: EmptyView(), onAppear: { issueDetails.fetch() })
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Close") {
                        dismiss()
                    }
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Save") {
                        print("SAved")
                    }
                })
            }
        }
    }
    
    init(issue: IssueGeneralDTO) {
        _issueDetails = StateObject(wrappedValue: IssueDetailsViewModel(issue: issue))
    }
}
