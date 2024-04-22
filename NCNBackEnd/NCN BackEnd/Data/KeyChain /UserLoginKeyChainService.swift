//
//  UserLoginKeyChainService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 25/04/23.
//

import Foundation
public class UserLoginKeyChainService {
    public init() {}
    var keyChain = KeychainManager.shared
}

extension UserLoginKeyChainService: UserLoginKeychainServicecontract {
    func userLoginKeychainUpdate(applicationName: String, userName: String, password: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        do {
            try keyChain.save(userName: userName, password: password, applicationName: applicationName)
            success("Stored log in information securely")
        } catch {
            failure("User Login failed")
        }
    }
}
