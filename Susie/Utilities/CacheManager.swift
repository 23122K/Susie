//
//  CacheManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

actor CacheManager<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
}

private extension CacheManager {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int {
            return key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            
            return value.key == key
        }
    }
}

private extension CacheManager {
    final class Entry {
        let value: Value
        
        init(_ value: Value) {
            self.value = value
        }
    }
}
