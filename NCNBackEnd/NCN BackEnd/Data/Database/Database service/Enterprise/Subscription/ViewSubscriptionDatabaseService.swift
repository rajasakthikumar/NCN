//
//  ViewSubscriptiondatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 27/03/23.
//

import Foundation
public class ViewSubscriptionDatabaseService: EnterpriseDatabaseService {
    override public init() {}

    var result: [AvailableSubscription] = []
}

extension ViewSubscriptionDatabaseService: ViewSubscriptionDatabaseServiceContract {
    public func viewSubscription(success: @escaping ([AvailableSubscription]) -> Void, failure: @escaping (String) -> Void) {
        let res = db.selectQuery(columnString: "*", tableName: "availableSubscription")

        guard let resultedArray = res else {
            failure("No  data")
            return
        }
//        ["subscriptionId","subscriptionPackageType", "subscriptionCountLimit", "subscritptionDayLimit", "serviceId"]
        print(resultedArray.count)
        for dict in resultedArray {
            if let subscriptionId = dict["subscriptionId"], let subscriptionPackageType = dict["subscriptionPackageType"], let subscriptionCountLimit = dict["subscriptionCountLimit"] as? Int, let subscriptionDaylimit = dict["subscritptionDayLimit"], let serviceId = dict["serviceId"] {
                var newAvailableSubscription = AvailableSubscription(subscriptionId: subscriptionId as! Int, subscriptionPackageType: subscriptionPackageType as? String, subscriptionCountLimit: subscriptionCountLimit, subscritptionDayLimit: subscriptionDaylimit as? Int, serviceId: serviceId as! Int)
                result.append(newAvailableSubscription)
            }
        }
        print(result)
        success(result)
    }
}
