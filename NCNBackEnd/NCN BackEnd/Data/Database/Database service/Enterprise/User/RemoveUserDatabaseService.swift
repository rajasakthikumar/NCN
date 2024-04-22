//
//  RemoveUserdatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 14/04/23.
//

import Foundation
public class RemoveUserDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension RemoveUserDatabaseService: RemoveUserDatabaseServiceContract {
    public func removeUser(userId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        db.deleteValue(tableName: "user", columnName: "userId", columnValue: String(describing: userId), success: success, failure: failure)
    }
}
