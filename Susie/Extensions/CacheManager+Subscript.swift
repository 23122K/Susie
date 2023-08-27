//
//  CacheManager+Subscript.swift
//  Susie
//
//  Created by Patryk Maciąg on 26/08/2023.
//

import Foundation

extension CacheManager {
    subscript(_ endpoint: Endpoint) -> CacheObject? {
        get { fetch(from: endpoint) }
        set {
            if let entry = newValue {
                //`insert(entry: CacheEntry, for: url) takes entry as its parameter
                //then entry is added to CacheObject
                insert(entry: entry, for: endpoint)
            } else {
                delete(endpoint: endpoint)
            }
        }
    }
}
