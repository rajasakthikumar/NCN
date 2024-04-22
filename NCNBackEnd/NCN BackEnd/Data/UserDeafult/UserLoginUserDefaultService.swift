//
//  UserLoginUserDefaultService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 25/04/23.
//

import Foundation
public class UserLoginUserDefaultService: EnterpriseUserDefaultService {
    override public init() {}
}

extension UserLoginUserDefaultService: UserLoginUserDefaultServiceContract {
    public func userLoginUserDefault(key: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        if let loggedIn = userDefault.retriveBoolData(key: key), !loggedIn {
            userDefault.saveBoolData(key: key, value: true)
            success("user has logged in")
        } else {
            failure("user is already logged in. please log out before logging in")
        }
    }
}
