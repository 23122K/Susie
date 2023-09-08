//
//  KeychainError.swift
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
