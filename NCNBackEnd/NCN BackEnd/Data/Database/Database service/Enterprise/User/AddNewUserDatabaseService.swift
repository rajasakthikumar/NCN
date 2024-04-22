//
//  AddUserDatabase.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 14/03/23.
//

import Foundation

public class AddNewUserDatabaseSerivce: EnterpriseDatabaseService {
    override public init() {}
}

extension AddNewUserDatabaseSerivce: AddNewUserDatabaseServiceContract {
    public func addNewUser(userName: String, password: String, email: String, mobilePhone: Int64, enterpriseId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        // create new User

        let columnName = ["userName", "password", "eMail", "mobileNumber", "enterpriseId"]
        let values: [Any] = [userName, password, email, mobilePhone, enterpriseId]

        db.insertStatement(tableName: "users", columnName: columnName, insertData: values, success: success, failure: failure)
    }
}

// write func to convert user to table field and employee fields
