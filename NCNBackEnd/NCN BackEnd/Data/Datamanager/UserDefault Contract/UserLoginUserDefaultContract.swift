//
//  UserLoginUserDefaultContract.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 25/04/23.
//

import Foundation
public protocol UserLoginUserDefaultServiceContract {
    func userLoginUserDefault(key: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void)
}
