//
//  TrackServiceDatabaseServcie.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 17/04/23.
//

import Foundation

// add a count to serviceusage in servicelink table
public class TrackServiceDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension TrackServiceDatabaseService: TrackServiceDatabaseServiceContract {
    public func trackService(id: Int, subscriptionUsage: Int, employeeId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        var subscriptionUsageOld = 0

        let columnString = "subscriptionUsage"
        let tableName = "serviceLinkTable"
        let whereClause = "id = \(id) AND employeeId = \(employeeId)"

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

        db.updateValue(tableName: "serviceLinkTable", columnValue: [newsubscriptionUsage], columnName: ["subscriptionUsage"], whereClause: "id = \(id) AND employeeId = \(employeeId)", success: success, failure: failure)
    }
}
