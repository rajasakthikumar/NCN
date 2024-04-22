//
//  ClientTrackServicedatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 18/04/23.
//

import Foundation
public class ClientTrackServiceDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension ClientTrackServiceDatabaseService: ClientTrackServiceDatabaseServiceContract {
    public func ClientTrackService(id: Int, subscriptionUsage: Int, userId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        var subscriptionUsageOld = 0
        let columnString = "subscriptionUsage"
        let tableName = "serviceLinkTable"
        let whereClause = "id = \(id) AND employeeId = \(userId)"

        if let rows = db.selectQuery(columnString: columnString, tableName: tableName, whereClause: whereClause) {
            print("Rows with subscriptionUsage:")
            for row in rows {
                if let subscriptionUsage = row["subscriptionUsage"] as? Int {
                    print("subscriptionUsage: \(subscriptionUsage)")
                    // Store the subscriptionUsage value in a variable
                    subscriptionUsageOld = subscriptionUsage
                }
            }
        } else {
            print("Failed to fetch rows.")
        }
        print("subscriptionUsageOld: \(subscriptionUsageOld)")
        var newsubscriptionUsage = subscriptionUsageOld + subscriptionUsage
        db.updateValue(tableName: "serviceLinkTable", columnValue: [newsubscriptionUsage], columnName: ["subscriptionUsage"], whereClause: "id = \(id) AND userId = \(userId)", success: success, failure: failure)
    }
}
