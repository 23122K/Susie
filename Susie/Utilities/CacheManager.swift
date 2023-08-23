//
//  CacheManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

class CacheManager {
    private let cache = NSCache<NSString, EntryObject>()
    
    func insertResponse(value: EntryObject, for url: URL) {
        cache.setObject(value, forKey: url.asNSString)
    }
    
    func fetchResponse(for url: URL) -> Entry? {
        cache.object(forKey: url.asNSString)?.entry
    }
    
    func deleteResponse(url: URL) {
        cache.removeObject(forKey: url.asNSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}

final class EntryObject {
    let entry: Entry
    
    init(entry: Entry) { self.entry = entry }
}

enum Entry {
    case pending(Task<Codable, Error>)
    case cached(Codable)
}

