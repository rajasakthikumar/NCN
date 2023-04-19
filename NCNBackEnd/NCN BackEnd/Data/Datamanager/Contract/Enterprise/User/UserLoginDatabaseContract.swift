//
//  UserLoginDatabaseContract.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 17/03/23.
//

import Foundation
public protocol UserLoginDatabaseContract {
    func userLogin(userName: String, password: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void)
}