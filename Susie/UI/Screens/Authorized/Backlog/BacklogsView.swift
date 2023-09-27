import SwiftUI

struct BacklogsView: View {
    @State private var draggedIssue: Issue?
    @State private var isInDropArea: Bool = false
    var body: some View {
        VStack { }
//        VStack{
//            HStack{
//                TabView {
//                    ForEach($vm.sprints) { sprint in
//                        ZStack{
//                            switch isInDropArea {
//                            case true:
//                                Color.red
//                            case false:
//                                Color.blue
//                            }
//                        }
//                        .onDrop(of: [.text], delegate: SprintDropDelegate(issue: $draggedIssue, source: $vm.issues, destination: sprint, isInDropArea: $isInDropArea))
//                    }
//                }
//                .tabViewStyle(.page(indexDisplayMode: .never))
//            }
//            .background(Color.red)
//            .background(ignoresSafeAreaEdges: .all)
//            .frame(height: 100)
//            VStack{
//                List{
//                    ForEach(vm.issues) { issue in
//                        IssueRowView(title: issue.name, tag: "YAY", color: .blue, assignetToInitials: "PM")
//                            .padding(.vertical, 5)
//                            .listRowSeparator(.hidden)
//                            .listRowInsets(EdgeInsets())
//                            .onDrag{
//                                draggedIssue = issue
//                                return NSItemProvider()
//                            }
//
//                    }
//                    .onMove(perform: { from, to in
//                        vm.issues.move(fromOffsets: from, toOffset: to)
//                    })
//                }
//                .scrollIndicators(.hidden)
//                .listStyle(PlainListStyle())
//                .scrollContentBackground(.hidden) //Disables list color
//            }
//        }
    }
}

