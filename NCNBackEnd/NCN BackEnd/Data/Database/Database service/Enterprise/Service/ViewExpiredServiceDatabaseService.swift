//
//  ViewExpiredServicedatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 17/04/23.
//

import Foundation
public class ViewExpiredServiceDatabaseService: EnterpriseDatabaseService {
    override public init() {}

    var resultedArray: [[String]] = []
}

extension ViewExpiredServiceDatabaseService: ViewExpiredServiceDatabaseServiceContract {
    public func viewExpiredService(success: @escaping ([[String]]) -> Void, failure: @escaping (String) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todayString = dateFormatter.string(from: Date())
        var result = db.selectQuery(columnString: "*", tableName: "serviceLinkTable", whereClause: "validTill < \'\(todayString)\'")
        print("result: \(result)")
        guard let resultantArray = result else {
            failure("No data")
            return
        }

        print("ans: \(resultantArray)")

        for field in resultantArray {
            if let userId = field["userId"] as? Int {
                print(userId)
                if let employeeId = field["employeeId"] as? Int {
                    print(employeeId)
                    if let serviceId = field["serviceId"] as? Int {
                        print(serviceId)
                        if let subscriptionId = field["subscriptionId"] as? Int {
                            print(subscriptionId)
                            if let enterpriseId = field["enterpriseId"] as? Int {
                                print(enterpriseId)
                                if let createdOn = field["createdOn"] as? String {
                                    print(createdOn)
                                    if let validTill = field["validTill"] as? String {
                                        print(validTill)
                                        if let subscriptionUsage = field["subscriptionUsage"] as? Int {
                                            print(subscriptionUsage)
                                            if let subscriptionUsageLimit = field["subscriptionUsageLimit"] as? Int {
                                                print(subscriptionUsage)
                                                var resultArray: [String] = [String(userId), String(employeeId), String(serviceId), String(subscriptionId), String(enterpriseId), String(createdOn), String(validTill), String(subscriptionUsage), String(subscriptionUsageLimit)]
                                                resultedArray.append(resultArray)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        success(resultedArray)
    }
}
