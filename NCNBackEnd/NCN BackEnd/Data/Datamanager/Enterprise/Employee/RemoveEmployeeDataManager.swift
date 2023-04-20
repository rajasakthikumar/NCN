//
//  RemoveEmployeeDataManager.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 10/04/23.
//

import Foundation
public class RemoveEmployeeDataManager {
    public var databaseService: RemoveEmployeeDatabaseServiceContract

    public init(databaseService: RemoveEmployeeDatabaseServiceContract) {
        self.databaseService = databaseService
    }

    private func success(response: String, callback: (String) -> Void) {
        callback(response)
    }

    private func failure(response: String, callback: (String) -> Void) {
        if response == "No avaialable service is found " {
            let error = "Sevice with this service id Doesn't exist"
            callback(error)
        }
    }
}

extension RemoveEmployeeDataManager: RemoveEmployeeDataContract {
    public func removeEmployee(employeeId: Int, userId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        databaseService.removeEmployee(employeeId: employeeId, userId: userId, success: {
            [weak self] message in
            self?.success(response: message, callback: success)
        }, failure: {
            [weak self] message in
            self?.failure(response: message, callback: failure)
        })
        
    }
    
}
