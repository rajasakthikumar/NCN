//
//  SetEnterpriseDataManager.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 20/03/23.
//

import Foundation
public class SetEnterpriseNameDataManager {
    var database: SetEnterpriseDatabaseServiceContract

    public init(database: SetEnterpriseDatabaseServiceContract) {
        self.database = database
    }

    private func success(response: String, callback: (String) -> Void) {
        callback(response)
    }

    private func failure(response: String, callback: (String) -> Void) {
        callback(response)
    }
}

extension SetEnterpriseNameDataManager: SetEnterpriseNameDataContract {
    public func setEnterpriseName(enterpriseName: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        database.setEnterpriseName(enterpriseName: enterpriseName, success: {
            [weak self] message in
            self?.success(response: message, callback: success)
        }, failure: {
            [weak self] message in
            self?.failure(response: message, callback: failure)
        })
    }
}
