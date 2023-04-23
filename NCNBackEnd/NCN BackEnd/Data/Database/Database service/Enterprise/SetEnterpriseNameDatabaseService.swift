//
//  SetEnterpriseNameDatabase.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 20/03/23.
//

import Foundation
public class SetEnterpriseDatabaseService {
    var db = Database.shared

    public init() {}
}

extension SetEnterpriseDatabaseService: SetEnterpriseDatabaseServiceContract {
    public func setEnterpriseName(enterpriseName _: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        db.insertStatement(tableName: "enterprise", columnName: ["enterpriseName"], insertData: ["random"], success: success, failure: failure)
    }
}
