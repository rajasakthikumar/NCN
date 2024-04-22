//
//  GetEnterpriseNetworkContract.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 21/04/23.
//

import Foundation
public protocol GetEnterpriseNameNetworkServiceContract {
    func getEnterpriseName(id: Int, success: @escaping (Enterprise) -> Void, failure: @escaping (String) -> Void)
}
