//
//  SideMenu.swift
//  Susie
//
//  Created by Patryk Maciąg on 06/10/2023.
//

import SwiftUI

public struct SideMenu<MenuContent: View>: ViewModifier {
    @Binding private var isPresented: Bool
    private let menuContent: MenuContent
    
    public init(isPresented: Binding<Bool>, @ViewBuilder menuContent: @escaping () -> MenuContent) {
        self.menuContent = menuContent()
        _isPresented = isPresented
    }
    
    public func body(content: Content) -> some View {
        let drag = DragGesture().onEnded { event in
            if event.location.x < 200 && abs(event.translation.height) < 50 && abs(event.translation.width) > 50 {
                withAnimation {
                    self.isPresented = event.translation.width > 0
                }
            }
        }
        
        lazy var sideMenu: some View = {
            GeometryReader { reader in
                ZStack(alignment: .leading) {
                    content
                        .blur(radius: isPresented ? 0.5 : 0)
                        .overlay(isPresented ? Color.black.opacity(0.15) : Color.black.opacity(0), ignoresSafeAreaEdges: .all)
                        .disabled(isPresented)
                        .frame(width: reader.size.width, height: reader.size.height)
                        .offset(x: isPresented ? reader.size.width / 2 : 0)
                        .animation(.easeInOut(duration: 0.2), value: isPresented)
                    
                    menuContent
                        .frame(width: reader.size.width / 2)
                        .transition(.move(edge: .leading))
                        .offset(x: isPresented ? 0 : -reader.size.width / 2)
                        .animation(.spring(), value: isPresented)
                }
                .gesture(drag)
            }
        }()
        
        return sideMenu
    }
}

public extension View {
    func sideMenu<MenuContent: View>(isPresented: Binding<Bool>, @ViewBuilder menuContent: @escaping () -> MenuContent) -> some View {
        self.modifier(SideMenu(isPresented: isPresented, menuContent: menuContent))
    }
}

