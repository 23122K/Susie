import SwiftUI

struct BacklogsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(content: {
                ToggableSection(title: "Sprint 1", isEditable: true, content: {
                    TaskView(title: "Test", tag: "BUG", color: .red, assignetToInitials: "PM")
                })
                .padding(.bottom, 5)
                Divider()
                ToggableSection(title: "Product backlog", content: {
                    TaskView(title: "Test", tag: "BUG", color: .red, assignetToInitials: "PM")
                    TaskView(title: "Test", tag: "BUG", color: .red, assignetToInitials: "PM")
                    Menu(content: {
                        Menu("Move to", content: {
                            Text("Sprint 1")
                        })
                        Button("Edit"){
                            
                        }
                    }, label: {
                        TaskView(title: "Test", tag: "BUG", color: .red, assignetToInitials: "PM")
                    })
                    ZStack{
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.white)
                        HStack{
                            Image(systemName: "plus")
                                .foregroundColor(.blue.opacity(0.5))
                            Text("Create new issue")
                                .bold()
                                .foregroundColor(.blue.opacity(0.5))
                        }
                    }
                    .padding()
                })
                Spacer()
            })
            .refreshable {
                print("Fetched")
            }
        }
    }
}


struct BacklogsView_Previews: PreviewProvider {
    static var previews: some View {
        BacklogsView()
    }
}

