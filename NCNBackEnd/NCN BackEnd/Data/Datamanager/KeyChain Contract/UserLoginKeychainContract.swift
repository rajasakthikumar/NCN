//
//  UserLoginKeychainContract.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 25/04/23.
//

import Foundation
protocol UserLoginKeychainServicecontract {
    func userLoginKeychainUpdate(applicationName: String, userName: String, password: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void)
}
