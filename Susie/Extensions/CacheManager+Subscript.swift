//
//  CacheManager+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 23/08/2023.
//

import Foundation

extension CacheManager {
    subscript(_ url: URL) -> Cache? {
        get { fetchResponse(for: url) }
        set {
            if let response = newValue {
                let value = ResponseCache(response: response)
                insertResponse(value: value, for: url)
            } else {
                deleteResponse(url: url)
            }
        }
    }
}
