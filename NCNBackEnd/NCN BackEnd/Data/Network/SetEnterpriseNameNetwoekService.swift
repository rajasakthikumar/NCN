//
//  SetEnterpriseNameNetwoekService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 24/04/23.
//

import Foundation
public class SetNetworkNameNetworkService {
    public init() { print("GetEnterpriseNameNetworkService") }
    var network = NetworkService.shared
}

extension SetNetworkNameNetworkService: SetEnterpriseNameNetworkServiceContract {
    public func getEnterpriseName(id: Int, enterprise: Enterprise, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        let jsonEncoder = JSONEncoder()
        var enterPrise: [String: Any] = [:]
        do {
            let jsonData = try jsonEncoder.encode(enterprise)
            if let dict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                enterPrise = dict
                print(dict)
            }
        } catch {
            print(error.localizedDescription)
        }
        network.postData(baseURL: "http://127.0.0.1:8000", endpoint: "post", id: id, data: enterPrise, success: {
            [weak self] message in
            self?.success(response: message, callback: success)
        }, failure: { [weak self] error in
            self?.networkFailure(error: error.localizedDescription, failure: failure)
        })
    }

    func success(response: String, callback: (String) -> Void) {
        callback(response)
    }

    func networkFailure(error: String, failure: @escaping (String) -> Void) {
        failure(error)
    }
}
