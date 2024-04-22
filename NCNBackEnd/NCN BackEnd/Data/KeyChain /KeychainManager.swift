//
//  KeychainManager.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 19/04/23.
//

import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()

    private init() {}

    enum KeychainError: Error {
        case detailsnotFound
        case unexpectedStatus(OSStatus)
        case invalidItemFormat
    }

    func save(userName: String, password: String, applicationName: String) throws {
        let passwordData = password.data(using: .utf8)!
        let query: [String: AnyObject] = [
            kSecAttrService as String: applicationName as AnyObject,
            kSecAttrAccount as String: userName as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: passwordData as AnyObject,
        ]

        let status = SecItemAdd(query as CFDictionary, nil)

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }

    func update(userName: String, newPassword: String, applicationName: String) throws {
        let passwordData = newPassword.data(using: .utf8)!
        let query: [String: AnyObject] = [
            kSecAttrService as String: applicationName as AnyObject,
            kSecAttrAccount as String: userName as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
        ]

        let attributesToUpdate: [String: AnyObject] = [
            kSecValueData as String: passwordData as AnyObject,
        ]

        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }

    func retrieve(userName: String, applicationName: String) throws -> String {
        let query: [String: AnyObject] = [
            kSecAttrService as String: applicationName as AnyObject,
            kSecAttrAccount as String: userName as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue,
        ]

        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &itemCopy)

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }

        guard let passwordData = itemCopy as? Data,
              let password = String(data: passwordData, encoding: .utf8)
        else {
            throw KeychainError.invalidItemFormat
        }

        return password
    }

    func delete(userName: String, applicationName: String) throws {
        let query: [String: AnyObject] = [
            kSecAttrService as String: applicationName as AnyObject,
            kSecAttrAccount as String: userName as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
        ]

        let status = SecItemDelete(query as CFDictionary)

        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
