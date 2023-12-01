//
//  AuthStore.swift
//  Susie
//
//  Created by Patryk Maciąg on 27/11/2023.
//

import Foundation

enum AuthKey: String {
    case accessAuth
    case refreshAuth
}

protocol AuthStore {
    func encode(_ auth: Auth) throws -> Data
    func decode(_ data: Data) throws -> Auth
    
    func insert(_ auth: Auth, for key: AuthKey) throws
    func fetch(key: AuthKey) throws -> Auth
    func update(key: AuthKey, with auth: Auth) throws
    func delete(key: AuthKey) throws
}

extension AuthStore {
    subscript(_ key: AuthKey) -> Auth? {
        get { try? self.fetch(key: key) }
        set {
            if let auth = newValue {
                do { try insert(auth, for: key) } catch KeychainError.authObjectExists {
                    do { try update(key: key, with: auth) } catch {
                        print("\(error) occured while updating keychain value for key \(key)")
                    }
                } catch {
                    print("\(error) occured while inserting keychain value for key \(key)")
                }
            } else {
                do { try delete(key: key) } catch {
                    print("\(error) occured while deleting keychain value for key \(key)")
                }
            }
        }
    }
}
