//
//  AddUserDatabase.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 14/03/23.
//

import Foundation

public class AddNewUserDatabase: AddNewUserDatabaseContract {
    public init() {}

    public func addNewUser(userName: String, password: String, email: String, mobilePhone: Int64, enterpriseId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        // create new User
        let db = Database.shared
        let columnName = ["userName", "password", "eMail", "mobileNumber", "enterpriseId"]
        let values: [Any] = [userName, password, email, mobilePhone, enterpriseId]

        db.insertStatement(tableName: "users", columnName: columnName, insertData: values, response: success, error: failure)
    }
}

// write func to convert user to table field and employee fields