//
//  SearchClientdatabaseService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 16/04/23.
//

import Foundation
public class SearchClientDatabaseSevice: EnterpriseDatabaseService {
    override public init() {}
    var userIdArr: [Int] = []
    var resultUser: [User] = []
}

extension SearchClientDatabaseSevice: SearchClientDatabaseServiceContract {
    public func searchClient(userId: Int, employeeId: Int, success: @escaping ([User]) -> Void, failure: @escaping (String) -> Void) {
        let joinClause = "JOIN serviceLinkTable ON users.userId = serviceLinkTable.userId"
        let whereClause = "serviceLinkTable.employeeId = \(employeeId) AND users.userId = \(userId);"
        let result = db.selectQuery(columnString: "*", tableName: "users", joinClause: joinClause, whereClause: whereClause)
        if result == nil {
            failure("No data")
        }
        guard let resultedArray = result else {
            failure("No data")
            return
        }
        print(resultedArray)

        // fetch userid first from servicelinktable

        // for fetching user from user table
        for dict in resultedArray {
            if let userName = dict["userName"] as? String,
               let email = dict["eMail"] as? String,
               let password = dict["password"] as? String,
               let mobileNumber = dict["mobileNumber"] as? Int,
               let enterpriseId = dict["enterpriseId"] as? Int
            {
                let newUser = User(userName: userName, email: email, password: password, mobileNumber: mobileNumber, enterpriseId: enterpriseId)
                resultUser.append(newUser)
            }
        }

        success(resultUser)
    }
}
