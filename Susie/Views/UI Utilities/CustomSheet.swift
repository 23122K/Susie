//
//  CustomSheet.swift
//  Susie
//
//  Created by Patryk Maciąg on 01/05/2023.
//

import SwiftUI

struct CustomSheet<Content: View>: View {
    let content: Content
    
    @Binding var isPresented: Bool
    
    @State private var isExtended: Bool = false
    @State private var height: CGFloat = 400
    
    init(isPresented: Binding<Bool>, content: () -> Content) {
        self.content = content()
        //self.secondContent = secondContent()
        _isPresented = isPresented
    }
    
    
    var body: some View {
        //Used to render view behind our custom sheet
        ZStack{
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.4))
            .ignoresSafeArea(.all)
            .opacity(isPresented ? 1 : 0)
            .animation(Animation.easeIn)
            .onTapGesture {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.15, execute: {
                    isPresented.toggle()
                })
            }
            VStack{
                Spacer()
                VStack{
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 50, height: 5)
                        .opacity(0.15)
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                        content
                    }
                    
                }
            }
            .frame(height: height)
            .offset(y: isPresented ? 0 : height)
            .animation(Animation.easeIn(duration: 0.15))
        }
        .gesture(DragGesture(minimumDistance: 5, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                switch(value.translation.width, value.translation.height) {
                case (-100...100, ...0):
                    isExtended = true
                    height = UIScreen.main.bounds.height * 0.75
                case (-100...100, 0...):
                    height = UIScreen.main.bounds.height/4
                    isExtended = false
                    isPresented.toggle()
                default:  print("no clue")
                }
            })
    }
}

struct CustomSheet_Previews<Content: View>: PreviewProvider {
    static var previews: some View {
        CustomSheet(isPresented: .constant(true), content: {
            Text("Hello")
        })
    }
}
