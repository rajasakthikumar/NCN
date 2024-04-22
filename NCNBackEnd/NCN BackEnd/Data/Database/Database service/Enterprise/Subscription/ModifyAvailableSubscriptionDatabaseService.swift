//
//  ModifyAvailableSubscriptiondatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 17/04/23.
//

import Foundation
public class ModifyAvailableSubscriptionDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension ModifyAvailableSubscriptionDatabaseService: ModifyAvailableSubscriptionDatabaseServiceContract {
    public func modifyAvailableSubscription(subscriptionId: Int, subscriptionPackageType: String, subscriptionCountLimit: Float, subscriptionDayLimit: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        let columnName = ["subscriptionPackageType", "subscriptionCountLimit", "subscritptionDayLimit"]
        let columnValue: [Any] = [subscriptionPackageType, subscriptionCountLimit, subscriptionDayLimit]
        db.updateValue(tableName: "availableSubscription", columnValue: columnValue, columnName: columnName, whereClause: "subscriptionId = \(subscriptionId)", success: success, failure: failure)
    }
}
