//
//  CreateAvaialableServicedatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 13/04/23.
//

import Foundation
public class CreateAvailableServicesDatabaseService: EnterpriseDatabaseService {
    override public init() {}

    func success(response _: String) {}
}

extension CreateAvailableServicesDatabaseService: CreateAvailableServicesDatabaseServiceContract {
    public func createAvailableServices(serviceId: Int, seviceTitle: String, serviceDescription: String, success: @escaping (AvailableService) -> Void, failure: @escaping (String) -> Void) {
        let columnName = ["serviceId", "serviceTitle", "serviceDescription", "enterpriseId"]
        let columnValue: [Any] = [serviceId, seviceTitle, serviceDescription, 12]
        db.insertStatement(tableName: "availableService", columnName: columnName, insertData: columnValue, success: self.success, failure: failure)

        var result = db.selectQuery(columnString: "*", tableName: "availableService", whereClause: "serviceId =  last_insert_rowid()")
        print("executed here")
        var res: [AvailableService] = []
        guard let resultedArray = result else {
            failure("No Data")
            return
        }
        for dict in resultedArray {
            if let subscriptionId = dict["serviceId"] as? Int {
                if let subscriptionPackageType = dict["serviceTitle"] as? String {
                    if let subscriptionCountLimit = dict["serviceDescription"] as? String {
                        let newAvailableSubscription = AvailableService(serviceId: subscriptionId, serviceTitle: subscriptionPackageType, serviceDescription: subscriptionCountLimit)

                        res.append(newAvailableSubscription)
                    }
                }
            }
        }
        print("resulted service: ", res)
        success(res[0])
    }
}
