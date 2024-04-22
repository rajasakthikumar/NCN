//
//  SearchEmployeeDatabase.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 16/04/23.
//

import Foundation
public class SearchEmployeeDatabaseService:
    EnterpriseDatabaseService
{
    override public init() {}

    var resultEmployee: [Employee] = []
}

extension SearchEmployeeDatabaseService: SearchEmployeeDatabaseServiceContract {
    public func searchEmployee(employeeId _: Int, success: @escaping ([Employee]) -> Void, failure: @escaping (String) -> Void) {
        var result = db.selectQuery(columnString: "*", tableName: "employee", joinClause: "JOIN users ON users.userId = employee.userId")

        guard let resultedArray = result else {
            failure("No data")
            return
        }

        for dict in resultedArray {
//
            if let userName = dict["userName"] as? String {
                if let email = dict["eMail"] as? String {
                    if let password = dict["password"] as? String {
                        if let mobileNumber = dict["mobileNumber"] as? Int {
                            if let enterpriseId = dict["enterpriseId"] as? Int {
                                if let employeeId = dict["employeeId"] as? Int {
                                    if let employmentType = dict["employeeTypeId"] as? Int {
                                        var employeeType: EmploymentType = .Trainee
                                        if employmentType == 1 {
                                            employeeType = .freelancer
                                        } else if employmentType == 2 {
                                            employeeType = .permanent
                                        } else if employmentType == 3 {
                                            employeeType = .contract
                                        } else if employmentType == 4 {
                                            employeeType = .Trainee
                                        } else if employmentType == 5 {
                                            employeeType = .admin
                                        }
                                        var newEmployee = Employee(userName: userName, email: email, password: password, mobileNumber: mobileNumber, employeeId: employeeId, employeeType: employeeType, enterpriseId: enterpriseId)
                                        resultEmployee.append(newEmployee)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        success(resultEmployee)
    }
}
