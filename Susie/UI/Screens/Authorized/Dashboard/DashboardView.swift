import SwiftUI
import Charts

struct DashboardView: View {
    @StateObject private var dashboard: DashboardViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
           ScreenHeader(user: dashboard.user, screenTitle: "Dashboard", action: {
               isPresented.toggle()
           }, content: {
               Menu(content: {
                   Button("Create sprint") {}
                   Button("Create issue") {}
               }, label: {
                   Image(systemName: "ellipsis")
                       .scaleEffect(1.1)
               })
           })
           .padding(.top)
           .padding(.horizontal)
            
            Spacer()
        }
    }
    
    init(project: Project) {
        _dashboard = StateObject(wrappedValue: DashboardViewModel(project: project))
    }
}

