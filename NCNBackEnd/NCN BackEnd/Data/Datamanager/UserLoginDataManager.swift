//
//  UserLoginDataManager.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 13/03/23.
//

import Foundation
public final class UserLoginDataManager {
    public var dataBase: UserLoginDatabaseContract

    public init(dataBase: UserLoginDatabaseContract) {
        self.dataBase = dataBase
    }

    private func success(message: String, callback: (String) -> Void) {
        callback(message)
    }

    private func failure(message: String, callback: (String) -> Void) {
        if message == "No Data" {
            let error = "User doesn't exist"
            callback(error)
        }
    }
}

extension UserLoginDataManager: UserLoginDataContract {
    public func userLogin(userName: String, password: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        dataBase.userLogin(userName: userName, password: password, success: {
            [weak self] message in
            self?.success(message: message, callback: success)
        },
        failure: {
            [weak self] message in

            self?.failure(message: message, callback: failure)
        })
    }
}