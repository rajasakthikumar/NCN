//
//  CreateQuerydatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 28/03/23.
//

import Foundation
public class CreateQueryDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension CreateQueryDatabaseService: CreateQueryDatabaseServiceContract {
    public func createQuery(queryId: Int, queryType: QueryType, queryMessage: String, queryDate: Date, userId: Int, employeeId: Int, enterpriseId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        let queryColumnName = ["queryId", "queryTypeId", "queryStatus", "queryMessage", "createdOn", "userId", "employeeId", "enterpriseId"]
        let date = queryDate.description
        let queryColumnValue: [Any] = [queryId, queryType.rawValue, false, queryMessage, date, userId, employeeId, enterpriseId]
        db.insertStatement(tableName: "query", columnName: queryColumnName, insertData: queryColumnValue, success: success,
                           failure: failure)
    }
}
