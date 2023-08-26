//
//  CacheManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

actor CacheManager {
    private let cache = NSCache<NSString, CacheObject>()
    private let dateProvider: () -> Date
    
    internal func insert(entry: CacheEntry, for url: URL) {
        let value = CacheObject(entry: entry)
        cache.setObject(value, forKey: url.asNSString)
    }
    
    internal func fetch(for url: URL) -> CacheEntry? {
        guard let entry = cache.object(forKey: url.asNSString)?.entry else {
            return nil
        }
        
        guard entry.expiresAt > dateProvider() else {
            return nil
        }
        
        return entry
    }
    
    internal func delete(url: URL) {
        cache.removeObject(forKey: url.asNSString)
    }
    
    func clearCache() async {
        cache.removeAllObjects()
    }
    
    init(dateProvider: @escaping () -> Date) {
        self.dateProvider = dateProvider
    }
}

//NSCache must take AnyObject as its parameter
final class CacheObject: NSDiscardableContent {
    let entry: CacheEntry
    
    internal func endContentAccess() { }
    internal func beginContentAccess() -> Bool { return true }
    internal func isContentDiscarded() -> Bool { return false }
    internal func discardContentIfPossible() { }
    
    init(entry: CacheEntry) {
        self.entry = entry
    }
}

struct CacheEntry {
    let status: Status
    let expiresAt: Date
    
    init(status: Status, expiresIn: TimeInterval = 5) {
        self.status = status
        self.expiresAt = Date().addingTimeInterval(expiresIn)
    }
}

struct CachePolicy {
    let shouldCache: Bool
    let shouldExpireIn: TimeInterval
    
    init(shouldCache: Bool, shouldExpireIn: TimeInterval = 0) {
        self.shouldCache = shouldCache
        self.shouldExpireIn = shouldExpireIn
    }
}

enum Status {
    case ongoing(Task<Codable, Error>)
    case completed
    case cached(Codable)
}

