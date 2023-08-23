//
//  CacheManager+Extension.swift
//  Susie
//
//  Created by Patryk Maciąg on 23/08/2023.
//

import Foundation

extension CacheManager {
    subscript(_ url: URL) -> Entry? {
        get { fetchResponse(for: url) }
        set {
            if let entry = newValue {
                let value = EntryObject(entry: entry)
                insertResponse(value: value, for: url)
            } else {
                deleteResponse(url: url)
            }
        }
    }
}
