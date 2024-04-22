//
//  GetEnterpriseDataManager.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 20/04/23.
//

import Foundation
public class GetEnterpriseNameDataManager {
    public var networkService: GetEnterpriseNameNetworkServiceContract

    public init(networkService: GetEnterpriseNameNetworkServiceContract) {
        print("GetEnterpriseNameDataManager")
        self.networkService = networkService
    }

    private func success(response: Enterprise, callback: (Enterprise) -> Void) {
        callback(response)
    }

    private func failure(response: String, callback: (String) -> Void) {
        callback(response)
    }
}

extension GetEnterpriseNameDataManager: GetEnterpriseNameDataContract {
    public func getEnterpriseName(id: Int, success: @escaping (Enterprise) -> Void, failure: @escaping (String) -> Void) {
        networkService.getEnterpriseName(id: id, success: {
            [weak self] response in
            self?.success(response: response, callback: success)
        }, failure: {
            [weak self] response in
            self?.failure(response: response, callback: failure)
        })
    }
}
