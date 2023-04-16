//
//  RemoveEmployeeDatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 14/04/23.
//

import Foundation
public class RemoveEmployeeDatabaseService {
    public init() {}
    var db = Database.shared
}

extension RemoveEmployeeDatabaseService: RemoveEmployeeDataContract {
    public func removeEmployee(employeeId: Int, userId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        db.deleteValue(tableName: "employee", columnName: "userId", columnValue: String(describing: userId),success: success, failure: failure)
        db.deleteValue(tableName: "user", columnName: "userId", columnValue: String(describing: userId),success: success, failure: failure)
    }
    
    
    
    
}
