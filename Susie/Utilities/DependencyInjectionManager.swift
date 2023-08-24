//
//  DependencyInjectionManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 16/05/2023.
//

import Foundation

//MARK: Protocol
public protocol InjectionKey {
    associatedtype Value
    static var currentValue: Self.Value {get set}
}

//MARK: Struct providing acces to injected dependencies
struct InjectedValues {
    /// This is only used as an accessor to the computed properties within extensions of `InjectedValues`.
    private static var current = InjectedValues()
    
    /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
    static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    /// A static subscript accessor for updating and references dependencies directly.
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

//MARK: Property wrapper
@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

//MARK: MODEL Extension
extension InjectedValues {
    var client: Client {
        get { Self[ClientKey.self] }
        set { Self[ClientKey.self] = newValue }
    }
}


//MARK: List ofe depencencies
private struct ClientKey: InjectionKey {
    static var currentValue: Client = Client()
}
