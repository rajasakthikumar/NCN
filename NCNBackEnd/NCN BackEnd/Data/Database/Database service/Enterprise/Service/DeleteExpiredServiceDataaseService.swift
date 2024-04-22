//
//  DeleteExpiredServiceDataaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 17/04/23.
//

import Foundation
public class DeleteExpiredServiceDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension DeleteExpiredServiceDatabaseService: DeleteExpiredServiceDatabaseServiceContract {
    public func deleteExpiredService(success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todayString = dateFormatter.string(from: Date())
        db.deleteValue(tableName: "serviceLinkTable", whereClause: " validTill < \'\(todayString)\'", success: success, failure: failure)
    }
}
