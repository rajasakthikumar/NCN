//
//  ViewServiceDatabase.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 23/03/23.
//

import Foundation
public class ViewServiceDatabaseService: EnterpriseDatabaseService {
    override public init() { print("db created") }

    var result: [AvailableService] = []
}

extension ViewServiceDatabaseService: ViewServiceDatabaseServiceContract {
    public func viewService(success: @escaping ([AvailableService]) -> Void, failure: @escaping (String) -> Void) {
        var res = db.selectQuery(columnString: "*", tableName: "availableService")

        guard let resultedArray = res else {
            failure("No  data")
            return
        }
        for dict in resultedArray {
            if let subscriptionId = dict["serviceId"] as? Int {
                if let subscriptionPackageType = dict["serviceTitle"] as? String {
                    if let subscriptionCountLimit = dict["serviceDescription"] as? String {
                        let newAvailableSubscription = AvailableService(serviceId: subscriptionId, serviceTitle: subscriptionPackageType, serviceDescription: subscriptionCountLimit)

                        result.append(newAvailableSubscription)
                    }
                }
            }
        }
        success(result)
    }
}
