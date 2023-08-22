//
//  KeychainManager.swift
//  Susie
//
//  Created by Patryk Maciąg on 22/08/2023.
//

import Foundation
import Security

enum KeychainError: Error {
    case entryNotFound
    case duplicateEntry
    case couldNotEncodeEntry
    case couldNotDecodeEntry
    case unexpectedStatus(OSStatus)
}

final class KeychainManager {
    private static func encode(_ value: String) throws -> Data {
        guard let data = value.data(using: .utf8) else {
            throw KeychainError.couldNotEncodeEntry
        }
        
        return data
    }
    
    static func insert(_ value: String, for key: String) throws {
        let data = try encode(value)
        let insertQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as CFDictionary
        
        let status = SecItemAdd(insertQuery, nil)
        guard status == errSecSuccess else {
            if status == errSecDuplicateItem {
                throw KeychainError.duplicateEntry
            }
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    static func fetch(key: String) throws -> String {
        let fetchQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecMatchLimit: 1,
            kSecReturnData: true
        ] as CFDictionary
        
        var data: AnyObject?
        let status = SecItemCopyMatching(fetchQuery, &data)
        
        guard status == errSecSuccess else {
            if status == errSecItemNotFound { throw KeychainError.entryNotFound }
            throw KeychainError.unexpectedStatus(status)
        }
        
        guard let result = String(data: data as! Data, encoding: .utf8) else {
            throw KeychainError.couldNotDecodeEntry
        }
        
        return result
    }
    
    static func update(key: String, with value: String) throws {
        let updateQuery = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as CFDictionary
        
        let data = try encode(value)
        let newValue = [
            kSecValueData: data
        ] as CFDictionary
        
        let status = SecItemUpdate(updateQuery, newValue)
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                throw KeychainError.entryNotFound
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

