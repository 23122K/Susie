//
//  CacheManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

class CacheManager {
    private let cache = NSCache<NSString, CacheObject>()
    private let dateProvider: () -> Date
    internal func insert(entry: CacheObject, for endpoint: Endpoint) {
        cache.setObject(entry, forKey: endpoint.uid.asNSString)
    }
    
    internal func fetch(from endpoint: Endpoint) -> CacheObject? {
        guard let entry = cache.object(forKey: endpoint.uid.asNSString) else {
            return nil
        }
        
        guard entry.expiresAt > dateProvider() else {
            return nil
        }
        
        return entry
    }
    
    internal func delete(endpoint: Endpoint) {
        cache.removeObject(forKey: endpoint.uid.asNSString)
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
    
    let status: Status
    let expiresAt: Date
    
    func endContentAccess() { }
    func beginContentAccess() -> Bool { return true }
    func isContentDiscarded() -> Bool { return false }
    func discardContentIfPossible() { }
    
    init(status: Status, expiresIn: TimeInterval = 5) {
        self.status = status
        self.expiresAt = Date().addingTimeInterval(expiresIn)
    }
}

struct CachePolicy {
    let shouldCache: Bool
    let shouldExpireIn: TimeInterval
    
    init(shouldCache: Bool = false, shouldExpireIn: TimeInterval = 5) {
        self.shouldCache = shouldCache
        self.shouldExpireIn = shouldExpireIn
    }
}

enum Status {
    case ongoing(Task<Codable, Error>)
    case completed
    case cached(Codable)
}

