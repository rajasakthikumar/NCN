//
//  MopdifyAvailableServicedatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 09/04/23.
//

import Foundation
public class ModifyAvailableServiceDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension ModifyAvailableServiceDatabaseService: ModifyAvailableServiceDatabaseServiceContract {
    public func modifyAvailableService(serviceId: Int, serviceTitle: String, serviceDescription: String, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        let columnName = ["serviceTitle", "serviceDescription"]
        let columnValue = [serviceTitle, serviceDescription]
        db.updateValue(tableName: "availableService", columnValue: columnValue, columnName: columnName, whereClause: "serviceId = \(serviceId)", success: success, failure: failure)
    }
}
