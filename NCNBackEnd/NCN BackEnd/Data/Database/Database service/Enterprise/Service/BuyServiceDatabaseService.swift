//
//  BuyServicedatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 29/03/23.
//

import Foundation
public class BuyServiceDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension BuyServiceDatabaseService: BuyServiceDatabaseServiceContract {
    public func buyService(userId: Int, employeeId: Int, serviceId: Int, subscritpionId: Int, enterpriseId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        var subscriptionUsage = 0.0
        var subscriptionUsageLimit = 0.0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        var daysToAdd = 10000 // Change this value to the number of days you want to add

        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)

        print(formattedDate)
        var result = db.selectQuery(columnString: "*", tableName: "availableSubscription", whereClause: "subscriptionId = \(subscritpionId)")
        if let firstResult = result?[0] {
           
            if let days = firstResult["subscritptionDayLimit"] as? Int,
               let subscriptionusage = firstResult["subscriptionCountLimit"] as? Int {
                daysToAdd = days
                subscriptionUsage = Double(subscriptionusage)
                subscriptionUsageLimit = Double(subscriptionusage)
            } else if let days = firstResult["subscritptionDayLimit"] as? Int {
                daysToAdd = days
            }

        }
        // creting new date from current date
        let presentDate = Date()

        let calendar = Calendar.current
        let dateComponents = DateComponents(day: daysToAdd)
        guard let newDate = calendar.date(byAdding: dateComponents, to: presentDate) else {
            print("Error creating new date.")
            return
                
        }

        let validTildate = dateFormatter.string(from: newDate)
        let queryColumnName = ["userId", "employeeId", "serviceId", "subscriptionId", "enterpriseId", "createdOn", "validTill", "subscriptionUsage", "subscriptionUsageLimit"]
        let queryColumnValue: [Any] = [userId, employeeId, serviceId, subscritpionId, enterpriseId, formattedDate, validTildate, subscriptionUsage, subscriptionUsageLimit]
        db.insertStatement(tableName: "serviceLinkTable", columnName: queryColumnName, insertData: queryColumnValue, success: success,
                           failure: failure)
    }
}
