//
//  ViewEmployeeClientdatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 16/04/23.
//

import Foundation
public class ViewEmployeeClientDatabaseService: EnterpriseDatabaseService {
    override public init() {}

    var resultUser: [User] = []
}

extension ViewEmployeeClientDatabaseService: ViewEmployeeClientDatabaseServiceContract {
    public func viewEmployeeClient(employeeId: Int, success: @escaping ([User]) -> Void, failure: @escaping (String) -> Void) {
        let joinClause = "JOIN serviceLinkTable ON users.userId = serviceLinkTable.userId"
        let whereClause = "serviceLinkTable.employeeId = \(employeeId)"
        var result = db.selectQuery(columnString: "*", tableName: "users", joinClause: joinClause, whereClause: whereClause)

        guard let resultedArray = result else {
            failure("No data")
            return
        }

        for dict in resultedArray {
            if let userName = dict["userName"] as? String {
                if let email = dict["eMail"] as? String {
                    if let password = dict["password"] as? String {
                        if let mobileNumber = dict["mobileNumber"] as? Int {
                            if let enterpriseId = dict["enterpriseId"] as? Int {
                                let newUser = User(userName: userName, email: email, password: password, mobileNumber: mobileNumber, enterpriseId: enterpriseId)
                                resultUser.append(newUser)
                            }
                        }
                    }
                }
            }
        }
        success(resultUser)
    }
}
