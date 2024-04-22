//
//  SetEnterpriseNameNetworkContract.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 24/04/23.
//

import Foundation
public protocol SetEnterpriseNameNetworkServiceContract {
    func getEnterpriseName(id: Int, enterprise: Enterprise, success: @escaping (String) -> Void, failure: @escaping (String) -> Void)
}
