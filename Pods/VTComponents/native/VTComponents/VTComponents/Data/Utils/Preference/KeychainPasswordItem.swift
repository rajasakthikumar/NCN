/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information

 Abstract:
 A struct for accessing generic password keychain items.
 */

import Foundation

struct KeychainPasswordItem {
    // MARK: Types

    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }

    // MARK: Properties

    let service: String

    private(set) var account: String

    let accessGroup: String?

    let sharedAppTargets: [String]?

    // MARK: Intialization

    init(service: String, account: String, accessGroup: String? = nil, sharedAppList: [String]? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
        sharedAppTargets = sharedAppList
    }

    // MARK: Keychain access

    func readData() throws -> Data {
        /*
             Build a query to find the item that matches the service, account and
             access group.
         */
        var query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup, sharedAppTargets: sharedAppTargets)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue

        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // Check the return status and throw an error if appropriate.
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }

        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
              let passwordData = existingItem[kSecValueData as String] as? Data
        else {
            throw KeychainError.unexpectedPasswordData
        }

        return passwordData
    }

    func saveData(_ data: Data) throws {
        do {
            // Check for an existing item in the keychain.
            try _ = readPassword()

            // Update the existing item with the new password.
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = data as AnyObject?

            let query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup, sharedAppTargets: sharedAppTargets)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        } catch KeychainError.noPassword {
            /*
                 No password was found in the keychain. Create a dictionary to save
                 as a new keychain item.
             */
            var newItem = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup, sharedAppTargets: sharedAppTargets)
            newItem[kSecValueData as String] = data as AnyObject?

            // Add a the new item to the keychain.
            let status = SecItemAdd(newItem as CFDictionary, nil)

            // Throw an error if an unexpected status was returned.
            guard status == noErr else { throw KeychainError.unhandledError(status: status) }
        }
    }

    func readPassword() throws -> String {
        let passwordData = try readData()
        guard let password = String(data: passwordData, encoding: String.Encoding.utf8) else {
            throw KeychainError.unexpectedPasswordData
        }
        return password
    }

    func savePassword(_ password: String) throws {
        // Encode the password into an Data object.
        let encodedPassword = password.data(using: String.Encoding.utf8)!
        try saveData(encodedPassword)
    }

    func readDict() throws -> [String: Any] {
        let passwordData = try readData()
        guard let dict = [String: Any].from(JSONData: passwordData) else {
            throw KeychainError.unexpectedPasswordData
        }
        return dict
    }

    func saveDict(_ dict: [String: Any]) throws {
        // Encode the password into an Data object.
        guard let encodedPassword = dict.jsonData else { return }
        try saveData(encodedPassword)
    }

    func readBool() throws -> Bool {
        let passwordData = try readData()
        guard let dict = Bool(from: passwordData) else {
            throw KeychainError.unexpectedPasswordData
        }
        return dict
    }

    func saveBool(_ bool: Bool) throws {
        // Encode the password into an Data object.
        guard let encodedPassword = bool.jsonData else { return }
        try saveData(encodedPassword)
    }

    mutating func renameAccount(_ newAccountName: String) throws {
        // Try to update an existing item with the new account name.
        var attributesToUpdate = [String: AnyObject]()
        attributesToUpdate[kSecAttrAccount as String] = newAccountName as AnyObject?

        let query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup, sharedAppTargets: sharedAppTargets)
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }

        account = newAccountName
    }

    func deleteItem() throws {
        // Delete the existing item from the keychain.
        let query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup, sharedAppTargets: sharedAppTargets)
        let status = SecItemDelete(query as CFDictionary)

        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }

    static func passwordItems(forService service: String, accessGroup: String? = nil, sharedAppTargets: [String] = []) throws -> [KeychainPasswordItem] {
        // Build a query for all items that match the service and access group.
        var query = KeychainPasswordItem.keychainQuery(withService: service, accessGroup: accessGroup, sharedAppTargets: sharedAppTargets)
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanFalse

        // Fetch matching items from the keychain.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // If no items were found, return an empty array.
        guard status != errSecItemNotFound else { return [] }

        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }

        // Cast the query result to an array of dictionaries.
        guard let resultData = queryResult as? [[String: AnyObject]] else { throw KeychainError.unexpectedItemData }

        // Create a `KeychainPasswordItem` for each dictionary in the query result.
        var passwordItems = [KeychainPasswordItem]()
        for result in resultData {
            guard let account = result[kSecAttrAccount as String] as? String else { throw KeychainError.unexpectedItemData }

            let passwordItem = KeychainPasswordItem(service: service, account: account, accessGroup: accessGroup, sharedAppList: sharedAppTargets)
            passwordItems.append(passwordItem)
        }

        return passwordItems
    }

    // MARK: Convenience

    private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil, sharedAppTargets: [String]? = nil) -> [String: AnyObject] {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?

        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }

        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }

        #if os(macOS)
            createAccessForQuery(query: &query, service: service, sharedAppTargets: sharedAppTargets)
        #endif
        return query
    }

    #if os(macOS)
        private static func createAccessForQuery(query: inout [String: AnyObject], service: String, sharedAppTargets: [String]? = nil) -> Bool {
            var secTrustSelf: SecTrustedApplication? = nil
            // `nil` creates `SecTrustedApplication` instance for caller app, aborting if it did go wrong
            if SecTrustedApplicationCreateFromPath(nil, &secTrustSelf) != errSecSuccess {
                return false
            }
            // Make an exception list of trusted applications; that is,
            // applications that are allowed to access the item without
            // requiring user confirmation:
            var trustedApplications: [SecTrustedApplication] = []
            if let secTrustSelf = secTrustSelf {
                trustedApplications.append(secTrustSelf)
            }
            // path of caller app
            let caller = ProcessInfo.processInfo.arguments[0]

            // Create trusted application references any other specified apps
            let sharedTargetPaths = sharedAppTargets ?? []
            for path in sharedTargetPaths {
                if FileManager.default.fileExists(atPath: path) && path != caller {
                    var secTrustedApp: SecTrustedApplication? = nil
                    if SecTrustedApplicationCreateFromPath(path.cString(using: .utf8),
                                                           &secTrustedApp) == errSecSuccess,
                        let secTrustedApp = secTrustedApp
                    {
                        trustedApplications.append(secTrustedApp)
                    }
                }
            }

            var access: SecAccess? = nil
            if SecAccessCreate(service as CFString, trustedApplications as CFArray, &access) == errSecSuccess {
                query[kSecAttrAccess as String] = access
            }

            return true
        }
    #endif

//    private static func createTrustedApp(for query: inout [String: AnyObject], service: String, appList: [String]) -> Bool {
//
//        var access: SecAccess?
//        var trustedApps = [SecTrustedApplication]()
//
//        // Make an exception list of trusted applications; that is,
//        // applications that are allowed to access the item without
//        // requiring user confirmation:
//        var secTrustApp: SecTrustedApplication?
//        let _keychainStatus: OSStatus = SecTrustedApplicationCreateFromPath( nil, &secTrustApp)
//
//        if _keychainStatus != errSecSuccess {
//            return false
//        }
//
//        if secTrustApp != nil {
//            trustedApps.append(secTrustApp!)
//        }
//
//        let caller = ProcessInfo.processInfo.arguments[0]
//        let fm = FileManager.default
//
//        for app in appList {
//            if fm.fileExists(atPath: app) && app != caller {
//                var secTrustApp: SecTrustedApplication?
//                let _keychainStatus: OSStatus = SecTrustedApplicationCreateFromPath( nil, &secTrustApp)
//
//                if _keychainStatus == errSecSuccess {
//                    if secTrustApp != nil {
//                        trustedApps.append(secTrustApp!)
//                    }
//                }
//            }
//        }
//
//        let _accessKeychainStatus = SecAccessCreate(service as CFString, trustedApps as CFArray, &access)
//
//        if _accessKeychainStatus == errSecSuccess {
//            query[kSecAttrAccess as String] = access
//        }
//
//        return true
//    }
}
