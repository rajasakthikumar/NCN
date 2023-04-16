//
//  DeleteQueryDatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 14/04/23.
//

import Foundation
public class DeleteQueryDatabaseService {
    public init() {}
    var db = Database.shared
}
extension DeleteQueryDatabaseService : DeleteQueryDatabaseContract {
    public func deleteQuery(queryId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        db.deleteValue(tableName: "query", columnName: "queryId", columnValue: String(describing: queryId),success: success, failure: failure)

    }
    
    
}
