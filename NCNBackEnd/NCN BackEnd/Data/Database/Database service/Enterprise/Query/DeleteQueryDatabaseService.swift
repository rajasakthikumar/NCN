//
//  DeleteQuerydatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 14/04/23.
//

import Foundation
public class DeleteQueryDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension DeleteQueryDatabaseService: DeleteQueryDatabaseServiceContract {
    public func deleteQuery(queryId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        db.deleteValue(tableName: "query", columnName: "queryId", columnValue: String(describing: queryId), success: success, failure: failure)
        db.deleteValue(tableName: "query", columnName: "queryStatus", columnValue: "\'true\'", success: success, failure: failure)
    }
}
