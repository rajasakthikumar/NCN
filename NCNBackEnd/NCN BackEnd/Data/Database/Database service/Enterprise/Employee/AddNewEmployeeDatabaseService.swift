//
//  AddNewEmployeeDatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 24/03/23.
//

import Foundation
public final class AddNewEmployeeDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension AddNewEmployeeDatabaseService: AddNewEmployeeDatabaseServiceContract {
    public func addEmployeeDetails(userName: String, password: String, email: String, mobilePhone: Int64, employeeType: Int, enterpriseId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        var userId = 0
        let userColumnName = ["userName", "password", "email", "mobileNumber", "enterpriseId"]
        let userColumndata: [Any] = [userName, password, email, mobilePhone, enterpriseId]

        let employeeColumnName = ["employeeTypeId", "userId"]

        // entering in user table
        db.insertStatement(tableName: "users", columnName: userColumnName, insertData: userColumndata, success: success, failure: failure)
        // entering in employee table
        let newUserId = db.selectQuery(columnString: "MAX(userId)", tableName: "users")
        print("userId:", newUserId)
        if let array = newUserId, let dictionary = array.first, let value = dictionary["MAX(userId)"] as? Int {
            userId = value
            print(value) // This will print 3
        }
        let employeeColumndata: [Any] = [employeeType, userId]
        db.insertStatement(tableName: "employee", columnName: employeeColumnName, insertData: employeeColumndata, success: success, failure: failure)
    }
}
