//
//  AssignQueryDataQuery.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 08/04/23.
//

import Foundation
public protocol AssignQueryDataContract {
    func assignQuery(employeeId: Int, queryId: Int, success: @escaping (String) -> Void, failure: @escaping (String) -> Void)
}
