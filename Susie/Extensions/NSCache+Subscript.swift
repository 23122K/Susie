//
//  NSCache+Subscript.swift
//  Susie
//
//  Created by Patryk Maciąg on 21/08/2023.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == ResponseObject {
    subscript(_ url: URL) -> RequestStatus? {
        get {
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        
        set {
            let key = url.absoluteString as NSString
            if let entry = newValue {
                let value = ResponseObject(entry: entry)
                setObject(value, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
}


