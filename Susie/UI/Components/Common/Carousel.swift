//
//  Carousel.swift
//  Susie
//
//  Created by Patryk Maciąg on 05/10/2023.
//

import SwiftUI

struct Carousel<T: Any, Content: View>: View {
    internal enum CarouselType {
        case bounded
        case unbounded
    }
    
    @State private var currentTab: Int
    private let height: CGFloat
    private let type: CarouselType
    private let data: Array<T>
    private let content: (T) -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                ForEach(Array(zip(data.indices, data)), id: \..0) { index, item in
                    content(item)
                        .frame(height: height)
                        .tag(index)
                }
            }
            .frame(height: 200)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: currentTab) { newTab in
                switch type {
                case .unbounded where newTab == 0:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        currentTab = data.count - 2
                    }
                case .unbounded where newTab == data.count - 1:
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        currentTab = 1
                    }
                default:
                    break
                }
                
            }
        }
        
//        switch type {
//        case .bounded:
//            HStack(spacing: 2) {
//                ForEach((0..<data.count), id: \.self) { index in
//                    Circle()
//                        .fill(index == self.currentTab ? Color.gray : Color.gray.opacity(0.5))
//                        .frame(width: 7, height: 7)
//                        .padding(.horizontal, 1)
//
//                }
//            }
//            .offset(y: -10)
//        case .unbounded:
//            HStack(spacing: 2) {
//                ForEach((1..<data.count-1), id: \.self) { index in
//                    Circle()
//                        .fill(index == self.currentTab ? Color.gray : Color.gray.opacity(0.5))
//                        .frame(width: 7, height: 7)
//                        .padding(.horizontal, 1)
//
//                }
//            }
//            .offset(y: -10)
//        }
    }
    
    public init(_ data: [T], type: CarouselType = .bounded, height: CGFloat = 200, @ViewBuilder _ content: @escaping (T) -> Content) {
        self.content = content
        self.height = height
        self.type = type
        
        switch type {
        case .unbounded:
            guard let firstElement = data.first, let lastElement = data.last else { fallthrough }
            
            var _data = data
            _data.append(firstElement)
            _data.insert(lastElement, at: 0)
            
            self.currentTab = 1
            self.data = _data
        case .bounded:
            self.currentTab = 0
            self.data = data
        }
    }
}
