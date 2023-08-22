//
//  KeychainManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation
import Security

enum KeychainError: Error {
    case authObjectNotFound
    case authObjectExists
    case couldNotEncodeAuthObject
    case couldNotDecodeAuthObject
    case unexpectedStatus(OSStatus)
}

final class KeychainManager {
    private static func encode(_ auth: Auth) throws -> Data {
        guard let data = try? JSONEncoder().encode(auth) else {
            throw KeychainError.couldNotDecodeAuthObject
        }
        
        return data
    }
    
    private static func decode(_ data: Data) throws -> Auth {
        guard let object = try? JSONDecoder().decode(Auth.self, from: data) else {
            throw KeychainError.couldNotEncodeAuthObject
        }
        
        return object
    }
    
    static func insert(_ auth: Auth, for key: String) throws {
        let data = try encode(auth)
        let insertQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as CFDictionary
        
        let status = SecItemAdd(insertQuery, nil)
        guard status == errSecSuccess else {
            if status == errSecDuplicateItem {
                throw KeychainError.authObjectExists
            }
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    static func fetch(key: String) throws -> Auth {
        let fetchQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecMatchLimit: 1,
            kSecReturnData: true
        ] as CFDictionary
        
        var data: AnyObject?
        let status = SecItemCopyMatching(fetchQuery, &data)
        
        guard status == errSecSuccess else {
            if status == errSecItemNotFound { throw KeychainError.authObjectNotFound }
            throw KeychainError.unexpectedStatus(status)
        }
        
        guard let object = try? decode(data as! Data) else {
            throw KeychainError.couldNotDecodeAuthObject
        }
        
        return object
    }
    
    static func update(key: String, with auth: Auth) throws {
        let updateQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        
        let data = try encode(auth)
        let newValue = [
            kSecValueData: data
        ] as CFDictionary
        
        let status = SecItemUpdate(updateQuery, newValue)
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                throw KeychainError.authObjectNotFound
            }
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    static func delete(key: String) throws {
        let deleteQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        
        let status = SecItemDelete(deleteQuery)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
