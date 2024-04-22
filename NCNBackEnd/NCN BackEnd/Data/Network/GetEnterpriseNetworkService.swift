//
//  GetEnterpriseNetworkService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 21/04/23.
//

import Foundation
public class GetEnterpriseNameNetworkService {
    public init() { print("GetEnterpriseNameNetworkService") }
    var network = NetworkService.shared
}

extension GetEnterpriseNameNetworkService: GetEnterpriseNameNetworkServiceContract {
    public func getEnterpriseName(id: Int, success: @escaping (Enterprise) -> Void, failure: @escaping (String) -> Void) {
        network.getData(baseURL: "http://127.0.0.1:8000", endpoint: "get", id: id, success: {
            [weak self] response in
            self?.dictionaryToEnterprise(dictionary: response, success: success, failure: failure)
        }, failure: { [weak self] error in
            self?.networkFailure(error: error.localizedDescription, failure: failure)
        })
    }
}

extension GetEnterpriseNameNetworkService {
    func dictionaryToEnterprise(dictionary: [String: Any], success: @escaping (Enterprise) -> Void, failure: @escaping (String) -> Void) {
        do {
            print("dictionaryToEnterprise called")
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let decoder = JSONDecoder()
            let enterprise = try decoder.decode(Enterprise.self, from: jsonData)
            print("Enterprise: \(enterprise)")
            success(enterprise)
        } catch {
            print("failure is being called")
            failure("Error converting dictionary to Enterprise: \(error)")
        }
    }

    func networkFailure(error: String, failure: @escaping (String) -> Void) {
        failure(error)
    }
}
