//
//  EnterpriseUserDefaultService.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 25/04/23.
//

import Foundation
public class EnterpriseUserDefaultService {
    public init() { userDefultIntialization() }
    var userDefault = UserDefaultsManager.shared
}

extension EnterpriseUserDefaultService {
    func userDefultIntialization() {
        userDefault.saveBoolData(key: "isLoggedIn", value: false)
    }
}
