//
//  SetEnterpriseNameDatabase.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 20/03/23.
//

import Foundation
public class SetEnterpriseDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension SetEnterpriseDatabaseService: SetEnterpriseDatabaseServiceContract {
    public func setEnterpriseName(enterpriseName: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        db.insertStatement(tableName: "enterprise", columnName: ["enterpriseName"], insertData: [enterpriseName], success: success, failure: failure)
    }
}
