//
//  CacheManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation

class CacheManager {
    private let cache = NSCache<NSString, ResponseCache>()
    private let dateProvider: () -> Date
    
    internal func insertResponse(value: ResponseCache, for url: URL) {
        cache.setObject(value, forKey: url.asNSString)
    }
    
    internal func fetchResponse(for url: URL) -> Cache? {
        guard let response = cache.object(forKey: url.asNSString)?.response else {
            return nil
        }
        
        guard response.expiresAt > dateProvider() else {
            deleteResponse(url: url)
            return nil
        }
        
        return response
    }
    
    internal func deleteResponse(url: URL) {
        cache.removeObject(forKey: url.asNSString)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
    
    init(dateProvider: @escaping () -> Date) {
        self.dateProvider = dateProvider
    }
}

final class ResponseCache: NSDiscardableContent {
    let response: Cache
    
    internal func endContentAccess() { }
    internal func beginContentAccess() -> Bool { return true }
    internal func isContentDiscarded() -> Bool { return false }
    internal func discardContentIfPossible() { }
    
    init(response: Cache) {
        print("ResponseCache has been initialised")
        self.response = response
    }
}

struct CachePolicy {
    let shouldCache: Bool
    let cacheExpiresIn: TimeInterval
    
    ///Default cache policy are `shouldCache = true` and `cacheExpiresIn = 15` seconds
    init(shouldCache: Bool = true, cacheExpiresIn: TimeInterval = 15) {
        self.shouldCache = shouldCache
        self.cacheExpiresIn = cacheExpiresIn
    }
}

struct Cache {
    public let status: RequestStatus
    public let expiresAt: Date

    init(status: RequestStatus) {
        self.status = status
        self.expiresAt = Date().add(seconds: 60)
    }
}

enum RequestStatus {
    case ongoing(Task<Codable, Error>)
    case cached(Codable)
}

