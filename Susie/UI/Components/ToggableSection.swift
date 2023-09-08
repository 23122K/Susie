//
//  ToggableSection.swift
//  Susie
//
//  Created by Patryk Maciąg on 02/05/2023.
//

import SwiftUI

struct ToggableSection<Content: View>: View {
    
    let content: Content
    let title: String
    let isEditable: Bool
    @State private var isPresented: Bool = false
    
    init(title: String, isEditable: Bool = false, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
        self.isEditable = isEditable
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                HStack{
                    HStack{
                        Image(systemName: isPresented ? "chevron.right" : "chevron.down" )
                        Text(title)
                            .font(.title3)
                    }
                    .onTapGesture {
                        isPresented.toggle()
                    }
                    
                    Spacer()
                    
                    if(isEditable){
                        Menu(content: {
                            Button("Start sprint"){
                                
                            }
                            Button("Edit sprint"){
                                
                            }
                        }, label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.blue)
                                .bold()
                        })
                    }
                }
                .frame(height: 60)
                .padding(.horizontal)
                Spacer(minLength: 1)
            }
            .foregroundColor(.blue.opacity(0.8))
            if(isPresented){
                content
            }
            
        }
    }
}

struct ToggableSection_Previews<Content: View>: PreviewProvider {
    static var previews: some View {
        ToggableSection(title: "Product backlog", content: {
            Text("Hello")
        })
    }
}
