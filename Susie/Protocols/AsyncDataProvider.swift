//
//  AsyncDataProvider.swift
//  Susie
//
//  Created by Patryk Maciąg on 14/10/2023.
//

import Foundation

@MainActor
protocol AsyncDataProvider: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func fetch()
}
