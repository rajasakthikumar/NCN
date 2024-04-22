//
//  UserLoginDatabase.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 13/03/23.
//

import Foundation
public class UserLoginDatabaseService: EnterpriseDatabaseService {
    override public init() {}
}

extension UserLoginDatabaseService: UserLoginDatabaseServiceContract {
    public func userLogin(userName: String, password: String, success: @escaping (User) -> Void, failure: @escaping (String) -> Void) {
        let values = db.selectQuery(columnString: "*", tableName: "users", whereClause: "userName = \'\(userName)\' AND password = \'\(password)\'")

        guard let resultValue = values?[0] else {
            failure("No Data")
            return
        }
        print(resultValue)
        guard let userName = resultValue["userName"] as? String,
              let email = resultValue["eMail"] as? String,
              let password = resultValue["password"] as? String,
              let mobileNumber = resultValue["mobileNumber"] as? Int,
              let enterpriseId = resultValue["enterpriseId"] as? Int, let userId = resultValue["userId"] as? Int
        else {
            failure("No Data")
            return
        }

        let user = User(userId: userId, userName: userName, email: email, password: password, mobileNumber: mobileNumber, enterpriseId: enterpriseId)
        success(user)
    }
}
